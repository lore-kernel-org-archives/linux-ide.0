From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Disabling Command Completion Coalescing (CCC) in SATA AHCI
Date: Thu, 19 May 2011 20:14:14 -0600
Message-ID: <4DD5CE76.9040003@gmail.com>
References: <BANLkTinPkdTkOQHNnPHwtXq2SMCo-uAALA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64182 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754851Ab1ETCOR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 May 2011 22:14:17 -0400
Received: by iyb14 with SMTP id 14so2579969iyb.19
        for <linux-ide@vger.kernel.org>; Thu, 19 May 2011 19:14:16 -0700 (PDT)
In-Reply-To: <BANLkTinPkdTkOQHNnPHwtXq2SMCo-uAALA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Pallav Bose <pallavbose@gmail.com>
Cc: linux-ide@vger.kernel.org

On 05/19/2011 02:32 PM, Pallav Bose wrote:
> Hello,
>
> I'm working on 2.6.35.9 version of the Linux kernel and am trying to
> disable Command Completion Coalescing. I have Native Command Queuing
> enabled by activating the RAID mode through the BIOS.
>
> I was looking at the Serial ATA AHCI 1.3 Specification and found on
> page 115 that -
>
> The CCC feature is only in use when CCC_CTL.EN is set to =911=92. If
> CCC_CTL.EN is set to =910=92, no CCC interrupts shall be generated.
>
> Next, I had a look at the relevant code (namely, the files concerning
> AHCI) for this version of the kernel but wasn't able to make any
> progress. I found the following enum constant - HOST_CAP_CCC =3D (1<<
> 7) - in drivers/ata/ahci.h, but I'm not sure how this should be
> modified to disable command coalescing. I did set HOST_CAP_CCC to 0
> but through some experiments that I conducted, I found that responses
> were being batched.

We don't use CCC. It always defaults to off and we don't turn it on.=20
Using CCC requires some additional code to handle it which isn't=20
implemented in the AHCI driver currently.

>
> I conducted an experiment wherein I issued requests of size 64KB from
> my driver code. 64KB corresponds to 128 sectors (each sector =3D 512
> bytes).
>
> When I look at the "response timestamp differences", here is what I f=
ind:
>
> Timestamp  | Timestamp |  Difference
>     at             |     at          |  in microsecs
> ------------------------------------------------------------
> Sector 255 - Sector 127 =3D  510
> Sector 383 - Sector 255 =3D  3068
> Sector 511 - Sector 383 =3D  22
> Sector 639 - Sector 511 =3D  22
> Sector 767 - Sector 639 =3D  12
> Sector 895 - Sector 767 =3D  19
> Sector 1023 - Sector 895 =3D  13
> Sector 1151 - Sector 1023 =3D  402
>
> As you can see, the _response timestamp_ differences seem to suggest
> that the write completion interrupts are being batched into one and
> then one single interrupt is being raised, which might explain the
> really low numbers (tens of microseconds.)

I suspect that there is something going on that you're not accounting=20
for. Are you sure that you're not getting multiple outstanding writes i=
n=20
parallel somehow? Although the controller won't batch completions, the=20
drive is free to do so if there are multiple queued commands outstandin=
g=20
at once (it can send a Set Device Bits FIS with multiple bits set).

>
> Clearly, there is some interrupt batching involved here which I need
> to disable so that an interrupt is raised for each and every write
> request. Will disabling CCC do the trick, or is there some more
> complexity involved?
>
> And yes, I did disable the write cache and a few other caches as well
> using the following commands:
>
> hdparm -a0 -W0 /dev/sdd;
> hdparm -m0 --yes-i-know-what-i-am-doing /dev/sdd;
> hdparm -A0 /dev/sdd;
>
> Here is another experiment that I tried.
>
> Create a bio structure in my driver and call the __make_request()
> function of the lower level driver. Only one 2560 bytes write request
> is sent from my driver.
>
> Once this write is serviced, an interrupt is generated which is
> intercepted by do_IRQ(). Finally, the function blk_complete_request()
> is called. Keep in mind that we are still in the top half of the
> interrupt handler (i.e., interrupt context, not kernel context). Now,
> we compose another struct bio in blk_complete_request() and call the
> __make_request() function of the lower level driver. We record a
> timestamp at this point (say T_0). When the request completion
> callback is obtained, we record another timestamp (call it T_1). The
> difference - T_1 - T_0 - is always above 1 millisec. This experiment
> was repeated numerous times, and each time, the destination sector
> affected this difference - T_1 - T_0. It was observed that if the
> destination sectors are separated by approximately 350 sectors, the
> time difference is about 1.2 millisec for requests of size 2560 bytes=
=2E
>
> Every time, the next write request is sent only when the previous
> request has been serviced. So, all these requests are chained and the
> disk has to service only one request at a time.
>
> My understanding is that since the destination sectors of consecutive
> requests have been separated by a fairly large amount, by the time th=
e
> next request is issued, the requested sector would be almost below th=
e
> disk head and thus the write should happen immediately and T_1 - T_0
> should be small (at least<  1 millisec).
>
> The following lines of code were inserted to block/blk-softirq.c
> starting at line number 112:
>
>          do_gettimeofday(&tv);
>          time_ms =3D (tv.tv_sec * 1000000) + (tv.tv_usec);
>          if(req&&  req->rq_disk&&  req->rq_disk->disk_name)
>          {
>             if(!strncmp(req->rq_disk->disk_name, "sdd", 3))
>             {
>                if(count<  10) // The experiment involves a total of 1=
0
> requests - 1 sent from my driver, and the remaining 9 from here.
>                {
>                   if(req->bio&&  (req->bio->bi_rw =3D=3D 1)&&
> req->bio->bi_bdev&&  req->bio->bi_bdev->bd_disk&&
> req->bio->bi_bdev->bd_disk->queue)
>                   {
>                      tracing_on();
>                      trace_printk("Count =3D %d: Receive Timestamp fo=
r
> sector #%llu =3D %lu microsecs; bi_size =3D %u\n", count,
> req->bio->bi_sector, time_ms, req->bio->bi_size);
>
>                      compose_bio_rw(&biop, req->bio->bi_bdev, NULL,
> NULL, 2560, 1); // This function (defined below) populates a bio
> structure
>
>                      biop->bi_sector =3D req->bio->bi_sector + 350;
>                      subq =3D req->bio->bi_bdev->bd_disk->queue;
>                      if (subq&&  subq->make_request_fn) {
>                         do_gettimeofday(&tv);
>                         time_ms =3D (tv.tv_sec * 1000000) + (tv.tv_us=
ec);
>                         trace_printk("Send Timestamp for sector #%llu=
 =3D
> %lu microsecs\n", biop->bi_sector, time_ms);
>                         count++;
>                         subq->make_request_fn(subq, biop);
>                      }
>                   }
>                }
>                else
>                {
>                   count =3D 0;
>                   tracing_off();
>                }
>             }
>         }
>
> static int compose_bio_rw(struct bio **biop, struct block_device *bde=
v,
>                     bio_end_io_t * bi_end_io, void *bi_private, int b=
i_size,
>                     int bi_vec_size)
>     {
>        struct page *bio_page;
>        struct bio *bio;
>        int order =3D 0, i =3D 0;
>
>        order =3D 0;
>
>        /* Grab a free page and free bio to hold the log record header=
 */
>        while (!(bio_page =3D alloc_pages(GFP_KERNEL, order))) {
>           printk("allocate header_page fails in compose_bio\n");
>           schedule();
>        }
>
>        while (!(bio =3D bio_alloc(GFP_ATOMIC, bi_vec_size
> /*MAX_BIO_VEC_NUM */ ))) {
>           printk("Allocate header_bio fails in compose_bio\n");
>           schedule();
>        };
>
>        for (i =3D 0; i<  bi_vec_size; i++) {
>           bio->bi_io_vec[i].bv_page =3D&bio_page[i];
>           bio->bi_io_vec[i].bv_offset =3D 0;
>           bio->bi_io_vec[i].bv_len =3D 2560;
>
>        }
>
>        bio->bi_sector =3D -1;              /* we do not know the dest=
_LBA yet */
>        bio->bi_bdev =3D bdev;           /* set header_bio with same v=
alue as bio */
>        bio->bi_vcnt =3D bi_vec_size;
>        bio->bi_idx =3D 0;
>        bio->bi_rw =3D 1;
>        bio->bi_size =3D bi_size;
>        bio->bi_end_io =3D bi_end_io;
>        bio->bi_private =3D bi_private;
>        *biop =3D bio;
>        return 0;
>     }
>
> The mass storage controller in the system is: Promise Technology, Inc=
=2E
> PDC20268 (Ultra100 TX2) (rev 02), and the HDD being used is: WD Cavia=
r
> Black (Model number - WD1001FALS).
>
> Thank you for reading this really really long mail and assisting me i=
n
> resolving this issue!
>
> Regards,
> Pallav
> --
> To unsubscribe from this list: send the line "unsubscribe linux-ide" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

