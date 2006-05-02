From: "Florian Nierhaus" <florian.p.nierhaus@gmail.com>
Subject: Re: data corruption with DMA enabled on K7VT4A PRO (VIA KT400A) - it was the memory
Date: Tue, 2 May 2006 23:21:15 +0200
Message-ID: <7285a92f0605021421l2ad59b4cm8b8c82f77b9b221b@mail.gmail.com>
Reply-To: fpn@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nproxy.gmail.com ([64.233.182.187]:17001 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964977AbWEBVVQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 May 2006 17:21:16 -0400
Received: by nf-out-0910.google.com with SMTP id a25so10531nfc
        for <linux-ide@vger.kernel.org>; Tue, 02 May 2006 14:21:15 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: mogensv@vip.cybercity.dk
Cc: Tyler <pml@dtbb.net>, linux-ide@vger.kernel.org

Hi,

I guess I trusted memtest86 too much. I wrote a little test tool to
see what data I write to the disk and read back and it seems I have a
little sticky bit somewhere, maybe the CPU cache hides it and it
really needs DMA to uncover it. Anyway one of my memory modules seems
to have turned bad. It works fine with the other one...

Thanks for all the good advice,
 Florian

On 4/26/06, Florian Nierhaus <florian.p.nierhaus@xxxxxx> wrote:
> Hi Everyone,
>
> Thanks for the Ram suggestion, but I kind of doubt it is the RAM.
>
> If I set things to hdparam -d1 -X udma1 things work fine. Also I only
> changed the mother board (to get SATA ports) and  the ram worked fine
> for over a year without any problems. Last not least I ran the
> memtest86 that is part of the fedora rescue CD and that didn't report
> any problems either. Also the thing that works best currently is my
> attached usb disk which also gives no problems.
>
> The problems are really the faster DMA modes with the SATA and PATA
> drive, and I did some experiments with diff and it did not look like
> bit changes which I would expect from bad ram, but more like large
> blocks beeing wrong (but I didn't check how big the blocks are.).
>
> Also the PATA cables are the same 80 lead cables I used before w/o
> problems. And on SATA I doubt it is the cables (tried two different
> ones).
>
> I am currently focusing on this:
> PCI: Via IRQ fixup for 0000:00:0f.1, from 255 to 0
> PCI: Via IRQ fixup for 0000:00:0f.0, from 10 to 0
>
> which I get with the 2.6.16-1.2069_FC4smp as well as 2.6.16.9-rc2.
>
> do you think this is the spot?
>
> thanks,
>  Florian Nierhaus
>
>
>
>
> On 4/22/06, Mogens Valentin <mogensv@xxxxxx> wrote:
> > Tyler wrote:
> > > Florian Nierhaus wrote:
> > >
> > >> I currently have data corruption when I md5sum large files on both my
> > >> SATA as well as my PATA drive. When I turn off DMA on the PATA drive
> > >> it is slow, but no data corruption - I havent figured out to turn off
> > >> DMA for the SATA.
> > >>
> > >>  If it helps, when I diff -u it looks like it is large blocks that are
> > >> missing/mixed up whatever, but not a bit here or there.
> > >>
> > >> This is the second board (but the same model) and still have the same
> > >> issue.
> > >>  The board seems to have a VIA KT400A as well as a VT8237.
> > >>
> > >
> > > I would suggest swapping your ram out for known tested-good chips,
> > > and/or even a different brand/model.  I had similar corruption on an
> > > Nforce4 system, transferring large files across the network, and it only
> > > stopped once I swapped out the ram (in my case, I removed the 512mb
> > > stick, and put a 256mb stick I had laying around).  I'm guessing that
> > > NOT using DMA may just be hiding a RAM issue.  There were no other
> > > symptoms, no crashes, etc, just screwed up files after transfers.
> > >
> > > You could also try raising the VDIMM voltage to 2.6 or 2.65 if your
> > > motherboard supports that option in the bios, it may be enough to make
> > > the ram stable.  I had another system that was having random oopses, and
> > > raising the VDIMM voltage cured it with two generic Samsung 512mb DDR
> > > chips running in dual-channel.
> >
> > If bad ram is the problem, running a loop building kernel and modules
> > usually results in sig11 errors as a good indicator, i.e.
> >    script make-test
> >    for i in 1 2 3 4 5; do
> >        make clean; make -j11 bzImage; make -j1 modules;
> >    done
> >
> > Anyways, you're easily right about ram quality. WRT raising voltage,
> > most BIOSs use .1volt incrementals, and I've yet to see a ram stick
> > having problems vith 2.7volt, so try that.
> > However, as a first step, ras-to-cas and Trp (cycle time) settings are
> > often the problematic ones. Try setting those a bit slower than default.
> > More than often, the SPD (prom on the stick with timings) has been
> > inadequately programmed, so read the ram specs and set them manually.
> > Sites like arstechnica and tomshardware has some good article/guides to
> > ram definitions and timings..
> >
> > --
> > Kind regards,
> > Mogens Valentin
> >
> >
