From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: sata_nv times out for BD-ROM iHOS104-08
Date: Tue, 19 Jan 2010 20:59:01 -0600
Message-ID: <51f3faa71001191859l3c323a8ev6b7c0cced2c59e92@mail.gmail.com>
References: <Pine.LNX.4.64.0912221105010.5876@stg.biology.emory.edu>
	 <4B31C8EE.3030003@kernel.org>
	 <d2d378040912232302u4b550dap687fcadced237935@mail.gmail.com>
	 <4B331771.3090309@kernel.org>
	 <d2d378041001161334r6fe3ee65w39cf98a6c2d1d399@mail.gmail.com>
	 <4B5666B4.6000804@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-iw0-f197.google.com ([209.85.223.197]:57655 "EHLO
	mail-iw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab0ATC7G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 19 Jan 2010 21:59:06 -0500
In-Reply-To: <4B5666B4.6000804@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: =?ISO-8859-1?Q?Cengiz_G=FCnay?= <cgunay@emory.edu>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

2010/1/19 Tejun Heo <tj@kernel.org>:
> Hello, Cengiz.
>
> On 01/17/2010 06:34 AM, Cengiz G=FCnay wrote:
>> 2009/12/24 Tejun Heo <tj@kernel.org>:
>>> I don't think the controller has anything to do with the issue but
>>> just in case can you please try it with a different controller?
>>
>> I tried the iHOS BD-ROM with a VIA VT6412 SATA controller today and =
it worked:
>
> Hmm.... it worked? =A0Does kernel parameter sata_nv.adma_enabled=3D0 =
make
> any difference? =A0Can you please attach boot log with the kernel
> parameter specified?

Think you meant maybe sata_nv.swncq=3D0 instead - this is an MCP51
controller so it doesn't support ADMA. I don't imagine SWNCQ would
make any difference with an ATAPI device, but wouldn't hurt to try.
