From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: IO errors after "block: remove bio_get_nr_vecs()"
Date: Tue, 22 Dec 2015 06:51:27 +0800
Message-ID: <CACVXFVN5t8wTzhx+YVXXDEvz=8ZhmROhFEKgrYgGGz6RNwMOfA@mail.gmail.com>
References: <CA+55aFwLyGifsQFdYZcWHeaHptxMqO_G25fZjer4R_yk4NtCpA@mail.gmail.com>
	<20151221065528.GA3873@htj.duckdns.org>
	<e53cb2f9d5882b0fbe82c589259bf043@lycos.com>
	<20151221193550.GM4026@mtj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:33223 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbbLUWv1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Dec 2015 17:51:27 -0500
In-Reply-To: <20151221193550.GM4026@mtj.duckdns.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: "Artem S. Tashkinov" <t.artem@lycos.com>, "Artem S. Tashkinov" <t.artem@mailcity.com>, Kent Overstreet <kent.overstreet@gmail.com>, Christoph Hellwig <hch@lst.de>, Ming Lin <ming.l@ssi.samsung.com>, Jens Axboe <axboe@fb.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Whitehouse <swhiteho@redhat.com>, IDE-ML <linux-ide@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Dec 22, 2015 at 3:35 AM, Tejun Heo <tj@kernel.org> wrote:
>
>> [   74.367632] XXX cmd=ee9e0260 cmd_tbl=ee9ed600 ahci_sg=ee9ed680
>> [   74.367634] XXX opts=140005 st=0 addr=2e9ed600 addr_hi=0 rsvd=0:0:0:0
>> [   74.367637] XXX fis=00608027:40218900:07000004:08000098 00000000:00000000:00000000:00001fff
>> [   74.367639] XXX qc->n_elem=20 fis_len=5 prdtl=20
>> [   74.367641] XXX sg[0] = 29007000 0 8fff (36864)
>> [   74.367643] XXX sg[1] = 29218000 0 7fff (32768)
>> [   74.367645] XXX sg[2] = 29298000 0 7fff (32768)
>> [   74.367646] XXX sg[3] = 29ad8000 0 7fff (32768)
>> [   74.367648] XXX sg[4] = 29338000 0 7fff (32768)
>> [   74.367650] XXX sg[5] = 29370000 0 2fff (12288)
>> [   74.367652] XXX sg[6] = 219000 0 2fff (12288)
>> [   74.367653] XXX sg[7] = 230000 0 3fff (16384)
>> [   74.367655] XXX sg[8] = 29373000 0 4fff (20480)
>> [   74.367657] XXX sg[9] = 29130000 0 ffff (65536)
>> [   74.367659] XXX sg[10] = 29170000 0 ffff (65536)
>> [   74.367660] XXX sg[11] = 29280000 0 ffff (65536)
>> [   74.367662] XXX sg[12] = 29200000 0 ffff (65536)
>> [   74.367664] XXX sg[13] = 29320000 0 ffff (65536)
>> [   74.367666] XXX sg[14] = 29360000 0 ffff (65536)
>> [   74.367667] XXX sg[15] = 29340000 0 ffff (65536)
>> [   74.367669] XXX sg[16] = 29350000 0 ffff (65536)
>> [   74.367671] XXX sg[17] = 29300000 0 ffff (65536)
>> [   74.367672] XXX sg[18] = 29310000 0 ffff (65536)
>> [   74.367674] XXX sg[19] = 29020000 0 7fff (32768)
>
> And everything checks out.  Data lenghts are consistent and all the
> addresses look kosher - at least nothing should upset the data
> transfer itself.

Maybe we can check more, such as if the sg element is correctly
merged from bvec, and the following code should be useful to check
that:

+static void ahci_dump_req(struct ata_queued_cmd *qc)
+{
+       struct scsi_cmnd *cmd = qc->scsicmd;
+       struct request *req = cmd->request;
+       struct req_iterator iter;
+       struct bio_vec bv;
+       int i = 0;
+       phys_addr_t paddr;
+
+       printk("%s: \n", __func__);
+       rq_for_each_segment(bv, req, iter) {
+               paddr = page_to_phys(bv.bv_page);
+               printk("\t %3d: %x-%x %x %u\n", i++,
+                       (unsigned)paddr & 0xffffffff,
+                       (unsigned)(paddr >> 32),
+                       bv.bv_offset,
+                       bv.bv_len);
+       }
+}

Thanks,
