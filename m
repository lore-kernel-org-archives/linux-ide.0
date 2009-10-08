From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH] ata: New PATA driver for Altera CompactFlash.
Date: Thu, 08 Oct 2009 09:56:59 +0800
Message-ID: <4ACD46EB.1040904@wytron.com.tw>
References: <1254964415-2809-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from msr25.hinet.net ([168.95.4.125]:34505 "EHLO msr25.hinet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754945AbZJHB4f (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 7 Oct 2009 21:56:35 -0400
Received: from darkstar.wytron.com.tw (www.wytron.com.tw [211.75.82.101])
	by msr25.hinet.net (8.9.3/8.9.3) with ESMTP id JAA12776
	for <linux-ide@vger.kernel.org>; Thu, 8 Oct 2009 09:55:56 +0800 (CST)
In-Reply-To: <1254964415-2809-1-git-send-email-thomas@wytron.com.tw>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

On 10/08/2009 09:13 AM, Thomas Chou wrote:
> From: Ian Abbott<abbotti@mev.co.uk>
>
> This patch adds a new PATA driver to support the Altera SOPC Builder
> CompactFlash component as a PATA device with support for insertion
> and removal of CF cards.  It uses the platform driver model.

Please cancel this one and use [PATCH v2] instead.

- Thomas
