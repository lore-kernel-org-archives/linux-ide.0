From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: turn set_irq() method into write_devctl() method
Date: Wed, 18 Mar 2009 21:23:05 +0100
Message-ID: <200903182123.06312.bzolnier@gmail.com>
References: <200903182033.55699.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:64175 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbZCRU7V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 18 Mar 2009 16:59:21 -0400
Received: by bwz17 with SMTP id 17so236390bwz.37
        for <linux-ide@vger.kernel.org>; Wed, 18 Mar 2009 13:59:18 -0700 (PDT)
In-Reply-To: <200903182033.55699.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 18 March 2009, Sergei Shtylyov wrote:
> Turn set_irq() method with its software reset hack into write_devctl() method
> (for just writing a value into the device control register) at last...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
