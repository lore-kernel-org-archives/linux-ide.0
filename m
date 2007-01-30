From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] libata: fix translation for START STOP UNIT
Date: Tue, 30 Jan 2007 09:24:37 -0500
Message-ID: <45BF5525.5040709@garzik.org>
References: <45BD4E0A.7060501@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:45966 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965472AbXA3OYj (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 30 Jan 2007 09:24:39 -0500
In-Reply-To: <45BD4E0A.7060501@shaw.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org

Robert Hancock wrote:
> Applies to 2.6.20-rc6.
> 
> ---
> 
> libata's SCSI translation for the SCSI START STOP UNIT command with the 
> START bit clear (i.e. stopping the drive) appears to be incorrect. It 
> sends an ATA STANDBY command with the time period set to 0, which the 
> code comment says means "now", but the ATA standard says this means 
> disable the standby timer, which effectively does nothing. Change this 
> to issue a STANDBY IMMEDIATE command which will actually spin the drive 
> down. The SAT (SCSI/ATA Translation) standard revision 9 concurs with 
> this choice.
> 
> Signed-off-by: Robert Hancock <hancockr@shaw.ca>

FWIW, I am having to apply Andrew Morton's version of your patches, 
because your patch form isn't quite right.  Review 
Documentation/SubmittingPatches and http://linux.yyz.us/patch-format.html

Most notably:

* Your patch description follows the "---" terminator, which is 
precisely the opposite of what should happen.  In the correct form, any 
comments such as "Applies to 2.6.20-rc6" should follow the "---" 
terminator, which in turn follows the patch description and signoff.

* Include the patch inline rather than as an attachment.  Even a 
text/plain attachment is very difficult to review and quote in popular 
email programs.

	Jeff


