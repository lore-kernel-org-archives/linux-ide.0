From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 7/9] libata-acpi: improve _GTF execution error handling
 and reporting
Date: Fri, 14 Dec 2007 23:15:32 +0900
Message-ID: <47629004.4040701@gmail.com>
References: <11976129411285-git-send-email-htejun@gmail.com> <11976129433239-git-send-email-htejun@gmail.com> <47628F3A.1060806@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.186]:40468 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752414AbXLNOPi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Dec 2007 09:15:38 -0500
Received: by rv-out-0910.google.com with SMTP id k20so955863rvb.1
        for <linux-ide@vger.kernel.org>; Fri, 14 Dec 2007 06:15:38 -0800 (PST)
In-Reply-To: <47628F3A.1060806@rtr.ca>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Mark Lord <liml@rtr.ca>
Cc: jeff@garzik.org, hancockr@shaw.ca, linux-ide@vger.kernel.org

Mark Lord wrote:
> Tejun Heo wrote:
>> As _GTF commands can't transfer data, device error never signals
>> transfer error.  It indicates that the device vetoed the operation, so
>> it's meaningless to retry.
> ..
> 
> The SECURITY commands may pass a data block to the drive,
> containing the password required to unlock/freeze a drive.
> I suspect ACPI on many machines will issue such a command,
> and it does indeed transfer data (512 bytes).

Surprise, ACPI _GTF can't do that.  Don't ask me why.  :-)

-- 
tejun
