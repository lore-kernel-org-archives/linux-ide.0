From: Steven Scholz <steven.scholz@imc-berlin.de>
Subject: Re: no DRQ after issuing MULTWRITE_EXT ?
Date: Thu, 01 Feb 2007 10:30:18 +0100
Message-ID: <45C1B32A.80606@imc-berlin.de>
References: <45C1B079.3080704@imc-berlin.de> <311601c90702010125k788a681fv2ec27de98ab05a72@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.imc-berlin.de ([217.110.46.186]:52380 "EHLO
	mx1.imc-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422705AbXBAJaV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 1 Feb 2007 04:30:21 -0500
In-Reply-To: <311601c90702010125k788a681fv2ec27de98ab05a72@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: linux-ide@vger.kernel.org

Eric,

>> I am seeing kernel messages like
>>
>> [ 1284.480000] hda: status timeout: status=0xd0 { Busy }
>> [ 1284.480000] ide: failed opcode was: unknown
>> [ 1284.480000] hda: no DRQ after issuing MULTWRITE_EXT
>> [ 1284.490000] ide0: unexpected interrupt, status=0x80, count=1
>> [ 1284.830000] ide0: reset: success
>> ...
> 
> Do you see this on every multiblock PIO write?  Or just occasionally?

Only occasionally.


--
Steven
