From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Subject: Re: [PATCH 2/2] libata: Fix NULL pointer of scsi_host in ata_port
Date: Thu, 24 Jul 2014 15:29:02 -0700
Message-ID: <CAEuXFEyzdciiMKTFcMCkLtDgYHDOWY2XnMXnyMkFwG9cAVvK6Q@mail.gmail.com>
References: <1406040688-1762-1-git-send-email-qiudayu@linux.vnet.ibm.com>
	<53CE7C29.6050908@linux.vnet.ibm.com>
	<CAEuXFExJAq5hpYe8R_De7hOtGN1Jrx6HCQt0tQBAKnDTKEpaBA@mail.gmail.com>
	<20140722201109.GN13851@htj.dyndns.org>
	<53CF7A73.8010402@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:33508 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbaGXW3E (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2014 18:29:04 -0400
In-Reply-To: <53CF7A73.8010402@ozlabs.ru>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Tejun Heo <tj@kernel.org>, Mike Qiu <qiudayu@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, wenxiong@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, zhenghch@cn.ibm.com, haokexin@gmail.com

On Wed, Jul 23, 2014 at 2:03 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> On 07/23/2014 06:11 AM, Tejun Heo wrote:
>> Hello,
>>
>> Can you please test the following patch?
>
> Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> on POWER8 + IBM IPR SCSI.

FWIW, I tested Linus's current git tree and the issue is fixed. Thanks!
