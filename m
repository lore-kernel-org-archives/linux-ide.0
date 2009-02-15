From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 14/18] ide: use ->tf_read in ide_read_error()
Date: Mon, 16 Feb 2009 02:21:33 +0300
Message-ID: <4998A37D.3040904@ru.mvista.com>
References: <20080620213323.13202.71450.sendpatchset@localhost.localdomain> <20080620213458.13202.77992.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:37780 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753651AbZBOXVi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 Feb 2009 18:21:38 -0500
In-Reply-To: <20080620213458.13202.77992.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

Bartlomiej Zolnierkiewicz wrote:

> * Add IDE_TFLAG_IN_FEATURE taskfile flag for reading Feature
>   register and handle it in ->tf_read.
>   

  Doesn't seem like a good name -- you can't read the features register. 
I should've commented to this patch earlier, of course...

MBR, Sergei


