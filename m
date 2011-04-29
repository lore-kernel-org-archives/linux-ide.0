From: Mark Lord <kernel@teksavvy.com>
Subject: Re: How to perform SECURITY ERASE on a SEC4 (security enabled/locked)
 PATA drive ?
Date: Fri, 29 Apr 2011 09:47:54 -0400
Message-ID: <4DBAC18A.20407@teksavvy.com>
References: <BANLkTikZt4Nr3DK3CkZXZ_ORgqjy-MGOUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181]:61873 "EHLO
	ironport2-out.pppoe.ca" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756082Ab1D2Nr4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Apr 2011 09:47:56 -0400
In-Reply-To: <BANLkTikZt4Nr3DK3CkZXZ_ORgqjy-MGOUA@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Maciej Grela <maciej.grela@gmail.com>
Cc: linux-ide@vger.kernel.org

On 11-04-27 04:15 PM, Maciej Grela wrote:
> Hi ata gurus,
> 
> I have a 2.5'' PATA drive with security enabled and unknown password.
> I'd like to erase that disk and use it. I've been trying to apply the
> instructions at the libata wiki:
> https://ata.wiki.kernel.org/index.php/ATA_Secure_Erase but they cover
> only the scenario in which the drive doesn't have security enabled
> before we start the procedure. In my case this approach doesn't work
> because I cannot set the password (step 3a):

First, update your hdparm to hdparm-9.37 from sourceforge.
Distros seem to continue to ship old versions for some weird reason,
and there have been lots of improvements since the 2008 copy they use.

Then, try this:


hdparm --security-set-pass NULL /dev/sdx
hdparm --security-erase NULL /dev/sdx


Cheers
-ml
