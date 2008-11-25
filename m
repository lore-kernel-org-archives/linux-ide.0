From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
Date: Tue, 25 Nov 2008 21:51:34 +0300
Message-ID: <492C4936.2030305@ru.mvista.com>
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com> <492BDB28.8020103@ru.mvista.com> <492C2BCE.60409@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:42443 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752279AbYKYSve (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 25 Nov 2008 13:51:34 -0500
In-Reply-To: <492C2BCE.60409@caviumnetworks.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Daney <ddaney@caviumnetworks.com>
Cc: linux-ide@vger.kernel.org, linux-mips@linux-mips.org

David Daney wrote:

>>   Wrong, -DIOR hold time is 5 ns for MWDMA0 as well as for all other 
>> modes.

> Point taken.

    Besides, I'm not sure how useful that timing could be for the host 
controller since it's apparently not determined by the host side -- it's for 
how long the device holds valid data after -DIOR is released IIRC.

WBR, Sergei
