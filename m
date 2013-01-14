From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH] Fix libata-eh don't retry command after reset succeeded.
Date: Mon, 14 Jan 2013 20:41:47 +0300
Message-ID: <50F4435B.1000705@mvista.com>
References: <201301141820562689358@gmail.com> <50F40FA8.4070101@teksavvy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:36672 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756645Ab3ANQng (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 14 Jan 2013 11:43:36 -0500
Received: by mail-la0-f48.google.com with SMTP id ej20so4107187lab.35
        for <linux-ide@vger.kernel.org>; Mon, 14 Jan 2013 08:43:34 -0800 (PST)
In-Reply-To: <50F40FA8.4070101@teksavvy.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: ycbzzjlby <ycbzzjlby@gmail.com>
Cc: Mark Lord <kernel@teksavvy.com>, jgarzik <jgarzik@redhat.com>, mlord <mlord@pobox.com>, linux-ide <linux-ide@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>

Hello.

On 01/14/2013 05:01 PM, Mark Lord wrote:

>> From 9cc9a85f17a8525e53caf430611d762c105d324c Mon Sep 17 00:00:00 2001
>> From: Bian Yu <ycbzzjlby@gmail.com>
>> Date: Tue, 18 Dec 2012 05:58:34 -0500
>> Subject: [PATCH] Fix libata-eh don't retry command after reset succeeded.
>>  It's introduced by commit 8d899e70c1b3afff, When disk has a UNC error,

   Please also specify that commit's summary in parens.

>>  qc->err_mask will set AC_ERR_MEDIA flag.
>>  Signed-off-by: Bian Yu <ycbzzjlby@gmail.com>

MBR, Sergei

