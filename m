From: Richard Scobie <r.scobie@clear.net.nz>
Subject: Re: SAS v SATA interface performance
Date: Sat, 01 Dec 2007 13:04:51 +1300
Message-ID: <4750A523.7010501@clear.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.sauce.co.nz ([210.48.49.72]:57184 "EHLO smtp.sauce.co.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759612AbXLAAGF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 30 Nov 2007 19:06:05 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Thanks for the comments.

It was really protocol/bus behaviour differences (if any), between SATA 
drives in a SAS environment, vs SAS drives, that I am looking at.

I do know that SATA drives only support a subset of the SCSI commands 
and wondered if the SAS drives were more "clever" in a multi drive scenario.

The comment I saw, which I'm trying to verify, mentioned the SATA drives 
"held the bus" or similar longer than SAS ones.

Regards,

Richard
