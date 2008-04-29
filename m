From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] siimage: add sil_* I/O ops
Date: Tue, 29 Apr 2008 14:45:51 +1000
Message-ID: <1209444351.18023.126.camel@pasglop>
References: <200804092051.33163.bzolnier@gmail.com>
	 <480A2926.6050404@ru.mvista.com>  <200804272148.29131.bzolnier@gmail.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40832 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542AbYD2EqG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 29 Apr 2008 00:46:06 -0400
In-Reply-To: <200804272148.29131.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

BTW. siimage crashes on boot here due to dma_ops being mostly full of
NULL... This is with current linus.

Ben.


