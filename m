From: "Greg Freemyer" <greg.freemyer@gmail.com>
Subject: Re: ST31000340NS (1000G) Capacity equal 33MB issue.
Date: Thu, 14 Feb 2008 13:29:52 -0500
Message-ID: <87f94c370802141029h59eb15cp33a4b136712fff84@mail.gmail.com>
References: <d0d565260802141013q61cb5e7fh7dcf04d7729213f7@mail.gmail.com>
	 <d0d565260802141018y63a988bbpc6aecf771baacb84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:1564 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619AbYBNS3z (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 14 Feb 2008 13:29:55 -0500
Received: by an-out-0708.google.com with SMTP id d31so84487and.103
        for <linux-ide@vger.kernel.org>; Thu, 14 Feb 2008 10:29:52 -0800 (PST)
In-Reply-To: <d0d565260802141018y63a988bbpc6aecf771baacb84@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Richard Liu <richliu.tw@gmail.com>
Cc: linux-ide@vger.kernel.org

On Thu, Feb 14, 2008 at 1:18 PM, Richard Liu <richliu.tw@gmail.com> wrote:
> Hello all:
>
>      I bought a Seagate ES.2 ST31000340NS (1000GB) and run at Gentoo
>  Linux kernel 2.6.24.
>  But Linux kernel report the disk size only 33MB.
>  I tried Intel ICH5 and Sil3112, but get the same result.
>
>  I don't know this issue was caused by libsata or scsi layer .
>
Don't ignore the controllers themselves.

I am in the process of upgrading the firmware on several 4 month old
sig 3512s because they won't even let the computer boot with a 1TB
drive connected.  ie. they lockup during the bios phase.

Previously, I've also had to upgrade older SIG PATA controllers to get
them to see past 500GB.

Sig has new firmware on their site, but you have to do the upload from
DOS.  (or supposedly windows.  Don't know about that.).  ie. use a
boot floppy or a boot thumb drive.

Greg
-- 
Greg Freemyer
Litigation Triage Solutions Specialist
http://www.linkedin.com/in/gregfreemyer
First 99 Days Litigation White Paper -
http://www.norcrossgroup.com/forms/whitepapers/99%20Days%20whitepaper.pdf

The Norcross Group
The Intersection of Evidence & Technology
http://www.norcrossgroup.com
