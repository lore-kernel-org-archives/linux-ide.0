From: "Theepan" <tornado@linuxfromscratch.org>
Subject: Re: IDE Performance issues
Date: Tue, 2 Sep 2003 15:48:40 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <01cf01c37158$ebd80750$0200a8c0@tornado>
References: <002a01c37117$68abc560$0200a8c0@tornado> <200309021419.55006.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from x1-6-00-a0-c9-de-85-f2.k78.webspeed.dk ([80.197.249.79]:48790
	"EHLO storm.stormchasers.dk") by vger.kernel.org with ESMTP
	id S263430AbTIBNtG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 2 Sep 2003 09:49:06 -0400
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

From: "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Theepan" <tornado@linuxfromscratch.org>
Cc: <linux-ide@vger.kernel.org>
Sent: Tuesday, September 02, 2003 2:19 PM
Subject: Re: IDE Performance issues


> > (I tried to send his mail to both linux-ide@ and linux-raid@ lists, but
it
> > only arrived at linux-raid@ - I guess one cannot specify multiple
targets
> > in the To: field, which is why I'm resending to this list only. I've
also
> > edited this email to exclude RAID details.)
>
> I think I've seen this mail on linux-ide@ previously.

The reason I thought it never arrived was simply because I didn't get this
e-mail back myself. It seems that I have been unsubscribed automatically
some time ago. Anyway, I am subscribed again and I didn't want to send
another mail to apologize the doubles, which would only create more traffic.
Consider this e-mail the apology e-mail. :)

> > zcav, a tool from bonnie++ package, was used to measure the sequential
read
> > rate. All disks were able to sustain minimum 30MB/s when accessed
> > seperately. When accessed simultaneously I get these results:
> >
> > When accessing 1 disk, the read rate was 30MB/s (as expected).
> > When accessing 2 disks, the read rate was 60MB/s (30MB/s on each disk,
as
> > expected)
> > When accessing 3 disks, the read rate was 60MB/s (20MB/s on each disk,
> > dropping 10Mb/s)
> > When accessing 4 disks, the read rate was 60MB/s (15MB/s on each disk,
> > dropping 15Mb/s)
>
> Have you tried with RAID0?
> What makes you think its IDE issue, not a RAID one?

It wouldn't do any good trying RAID0 if the underlying layer cannot deliver
the data faster. The 4 above "benchmarks" are performed directly on the
disks rather than on the RAID setup, which eliminates any overhead RAID may
bring.

--
Theepan


