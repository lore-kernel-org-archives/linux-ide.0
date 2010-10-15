From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH #upstream-fixes] libahci: fix result_tf handling after
 an ATA PIO data-in command
Date: Fri, 15 Oct 2010 10:45:54 +0200
Message-ID: <4CB814C2.6030404@kernel.org>
References: <4C9C3878.9010206@teksavvy.com>	<AANLkTi=85A9ueu9YYrh0jOKFgc+fqbaUhkRLt7=Bzx2M@mail.gmail.com>	<4C9C44D0.1030409@teksavvy.com>	<AANLkTinOECHi_7+y7yT-GZXxW0c4vrJOuRz80kejt2+N@mail.gmail.com>	<4C9CA385.5090709@teksavvy.com>	<4C9CA673.4090104@teksavvy.com>	<4C9D33C0.8050900@gmail.com>	<4CA99BCB.8080904@gmail.com>	<4CAA0885.8060906@teksavvy.com>	<4CAA0996.5080403@teksavvy.com>	<4CAA0F6C.6080609@teksavvy.com>	<4CAA21F4.5060000@teksavvy.com>	<4CAA2AA6.2010204@pobox.com>	<4CAA2C6F.2090603@teksavvy.com>	<4CAA2E16.4010905@pobox.com>	<4CAA3033.8030405@teksavvy.com>	<4CAACEBE.1000104@gmail.com>	<4CAB30FA.2010508@teksavvy.com>	<4CAB4CE9.9070709@gmail.com>	<AANLkTin=QWXcuy6JOi1y26dWH8FG1ji3JewTXu0K=4ri@mail.gmail.com>	<4CB6C50F.60609@kernel.org>	<4CB7783A.2050604@teksavvy.com> <AANLkTinW+o8
 qW1PO+OSNEeRsFr+zQ4QTG6017p97K6cH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55029 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab0JOIqc (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 15 Oct 2010 04:46:32 -0400
In-Reply-To: <AANLkTinW+o8qW1PO+OSNEeRsFr+zQ4QTG6017p97K6cH@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, Jeff Garzik <jgarzik@pobox.com>, Seed <seedrubbish@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>, stable@kernel.org

On 10/15/2010 02:24 AM, Robert Hancock wrote:
>> I'm not certain, but doesn't this problem also affect DMA_TO_DEVICE PIO
>> commands?
>> Eg. SECURITY_ERASE_PREPARE and PIO_WRITE ?
> 
> No, PIO data-out commands send a D2H register FIS after completion. It
> appears that PIO data-in is the only special case.

Yeap, it's an exception only for PIO data-in's.

Thanks.

-- 
tejun
