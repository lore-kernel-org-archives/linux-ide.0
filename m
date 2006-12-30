From: Steve Graham <stgraham2000@yahoo.com>
Subject: Re: SIL3512 lockup problem using driver verion 0.9 and Linux 2.6.14
Date: Sat, 30 Dec 2006 10:53:06 -0800 (PST)
Message-ID: <227868.71850.qm@web52301.mail.yahoo.com>
References: <457E040D.2020707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web52301.mail.yahoo.com ([206.190.48.144]:24168 "HELO
	web52301.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030298AbWL3S7r (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Dec 2006 13:59:47 -0500
In-Reply-To: <457E040D.2020707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi Tejun,

Sorry it took some time to respond.  I went away for
th holidays and just returned yesterday.

We were using linux 2.6.14.  I saw a message on one of
the forums that suggested moving to linux 2.6.18
because of improved error handling to fix this
problem.  I tried that by moving the entire SCSI
framework from 2.6.18 into 2.6.14 (The full 2.6.18 is
not stable on our platform).

Anyhow, after doing this difficult task I managed to
get rid of the lockups but I still get error messages
and drive 'stalls'.  Unfortunately, I don't have them
recorded anywhere because the error messages don't
seem to hurt anything.  The drive locks for about 30
seconds, the driver does a 'soft reset' and then the
drive comes back alive.  It's far from optimal but at
least the system is usable.

I will try to repeat the test and get the error
messages again so I can send them to you but if you
have any ideas before then please let me know.

Cheers,

Steve...

--- Tejun Heo <htejun@gmail.com> wrote:

> Hello,
> 
> Steve Graham wrote:
> > My name is Steve Graham and I work for a small
> > startup.  Our company is developing a server board
> > with the Silicon Images 3512 and we are getting
> some
> > strange lockups during high levels of disk
> activity. 
> > The test I'm currently running to cause the
> problem is
> > to run the following concurrently: 'nbench',
> > 'tiobench', and an 'scp' of a 200Meg file to the
> sata
> > drive.  Every so often I will get the following
> > message:
> > 
> > ata1: status=0x51 { DriveReady SeekComplete Error
> }
> >   ata1: error=0x04 { DriveStatusError }
> 
> Which kernel version are you running?
> 
> > This doesn't mean the drive is locked up and
> doesn't
> > appear to have any side effects on its own but
> > eventually I will get the above message that is
> > immediately followed by the next block of messages
> > that do result in a lockup:
> > 
> > ata1: command 0x35 timeout, stat 0xd1 host_stat
> 0x1
> >   ata1: status=0xd1 { Busy }
> >   sd 0:0:0:0: SCSI error: return code = 0x8000002
> >   sda: Current: sense key=0xb
> >       ASC=0x47 ASCQ=0x0
> >   end_request: I/O error, dev sda, sector 17033103
> >   ata1: Abnormal status 0xD1 on port 0xC001E087
> >   ata1: Alternate status 0xD1 on port 0xC001E08A
> >   ata1: Error 0xd1
> >   ata1: Abnormal status 0xD1 on port 0xC001E087
> >   ata1: Alternate status 0xD1 on port 0xC001E08A
> >   ata1: Error 0xd1
> >   ata1: Abnormal status 0xD1 on port 0xC001E087
> >   ata1: Alternate status 0xD1 on port 0xC001E08A
> 
> This is message from old error handling and doesn't
> really contain much
> useful info.  Even if you have to use previous
> kernel in production
> system, providing error messages from 2.6.19 will
> help chasing down the
> cause.
> 
> -- 
> tejun
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
