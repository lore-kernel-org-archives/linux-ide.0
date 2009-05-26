From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 1/3] ide: add "ignore_hpa" module parameter
Date: Tue, 26 May 2009 17:49:09 -0600
Message-ID: <4A1C7FF5.4060205@gmail.com>
References: <200905252344.11826.bzolnier@gmail.com> <200905260106.13705.elendil@planet.nl> <200905261423.40117.bzolnier@gmail.com> <200905261453.22428.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:62015 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846AbZEZXtO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 26 May 2009 19:49:14 -0400
In-Reply-To: <200905261453.22428.elendil@planet.nl>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Frans Pop wrote:
>> Moreover the (much needed) work from Tejun doesn't help a tiny bit in
>> case of people migrating their *working* setups from IDE to libata
> 
> From what I've seen now that seems the most important case that needs 
> supporting, as well as the case where a working setup would migrate from 
> IDE with old HPA default to IDE with new HPA default.
> 
> Naive thought: wouldn't it be possible to check whether a partition 
> overlaps the HPA boundary and warn or even bug out in that case?

It does, you get a warning about the partition exceeding device 
capacity. Easy to miss that, however.
