From: "Jonas Jensen" <jonas.jensen@gmail.com>
Subject: Re: pata_via "frozen" DVD drive (TSSTcorp SN-S083A on EPIA EX15000)
Date: Wed, 15 Oct 2008 11:44:45 +0200
Message-ID: <338a6b6d0810150244w2ef4e0a4q482c866113aa6595@mail.gmail.com>
References: <338a6b6d0810140230t16f8da53y6facbcee174cad3@mail.gmail.com>
	 <48F598FA.9060500@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:62723 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbYJOJoq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 15 Oct 2008 05:44:46 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2833310rvb.1
        for <linux-ide@vger.kernel.org>; Wed, 15 Oct 2008 02:44:46 -0700 (PDT)
In-Reply-To: <48F598FA.9060500@kernel.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org

On 15/10/2008, Tejun Heo <tj@kernel.org> wrote:
> The drive times out SEND_OPC and then never comes back.  The command
> is non-data command which just tells the drive to perform calibration,
> so there's nothing much the driver can do wrong about it.  It looks
> like the drive could have hardware problem performing OPC.  Can you
> test the drive under different operating system or different hardware
> configuration (different controller, different media, etc...)?

Thank you for your reply,

I tested the drive some more yesterday and found that it doesn't have
the same problem on CD-RW media. And the FujiFilm DVD-RW that causes
the problem it has no problem reading from. I'm not sure if it's just
that brand but it seems like it's a problem with the media. However,
it surprises me that bad media can cause the drive to fail into an
unrecoverable state. Looks like a cheap shitty device, atleast it
wasn't expensive :)

I can test the device under different OS/controller if you feel like
you need that information.

Best regards,
Jonas
