From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH 9/10] drivers/ata: introduce missing kfree
Date: Sat, 15 Aug 2009 11:15:51 +0400
Message-ID: <20090815111551.78852e61@realm>
References: <Pine.LNX.4.64.0908011055050.23408@ask.diku.dk>
	<4A77BDCC.1070502@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f214.google.com ([209.85.219.214]:47363 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbZHOHaV (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Aug 2009 03:30:21 -0400
Received: by ewy10 with SMTP id 10so1964038ewy.37
        for <linux-ide@vger.kernel.org>; Sat, 15 Aug 2009 00:30:22 -0700 (PDT)
In-Reply-To: <4A77BDCC.1070502@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Julia Lawall <julia@diku.dk>, jgarzik@pobox.com, linux-ide@vger.kernel.org

Hi,

> cc'ing Matyukevich Sergey.  Matyukevich, is it possible to use
> devm_kzalloc() instead?

Many thanks for review and fixes. 
Your final patch with devm_kzalloc is just fine.

Sergey
