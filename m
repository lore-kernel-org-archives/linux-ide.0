From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: Errors and resets using sata_promise and libata 1.20
Date: Sat, 15 Jul 2006 09:31:01 -0400
Message-ID: <87f94c370607150631g6f91d6fav511cdd8411b39af5@mail.gmail.com>
References: <1152725383.23607.5637.camel@girvin.pmc-sierra.bc.ca>
	 <44B7D4E4.4000607@rtr.ca> <20060715065001.GA11832@localnet>
	 <44B8E8D6.8020903@rtr.ca> <20060715132012.GA18761@localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:38042 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946037AbWGONbD (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 15 Jul 2006 09:31:03 -0400
Received: by nf-out-0910.google.com with SMTP id o25so137162nfa
        for <linux-ide@vger.kernel.org>; Sat, 15 Jul 2006 06:31:01 -0700 (PDT)
In-Reply-To: <20060715132012.GA18761@localnet>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: sr@gimp.org
Cc: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org

On 7/15/06, Sven Riedel <sr@gimp.org> wrote:
> > >Is there a patch somewhere that didn't make it into the kernel yet, that we
> > >can try?
> >
> > No.  And it's quite unfortunate, as this bug prevents proper error handling
> > by the SCSI layer, since libata doesn't accurately report what problem it
> > saw.
> >
>
> Ok. Well, since I can duplicate the exact same error here consistently, I'll
> grab 2.6.18rc1 and report back if I can reproduce the error there or not.
>
If you don't want to try the whole 2.6.18.rc1 kernel, the new EH is
available as a big patch for 2.6.17

Cut and paste from Tejun Heo's announcement on July 10:
===
Updated version available.

* Link resume handling in the previous version was broken causing libata
to ignore hotplug event after a link has been hot-unplugged.  Fixed.

* A few other hotplug related problems are fixed.

I expect this version to have well-behaving PMP and hotplug support. If
anything seems weird, please report.

More info can be found at the following URL.

http://home-tj.org/wiki/index.php/Libata-tj-stable

Updated patches against v2.6.17.4 are at the following URL.

http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17.4-20060710.tar.bz2
==

HTH
Greg
-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
