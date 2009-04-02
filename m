From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH resend 1/2] at91_ide: remove custom tf_{read|load}() methods
Date: Thu, 2 Apr 2009 21:19:08 +0200
Message-ID: <200904022119.09075.bzolnier@gmail.com>
References: <200904012320.58551.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:58010 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763452AbZDBTgn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 15:36:43 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so685131fxm.37
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2009 12:36:41 -0700 (PDT)
In-Reply-To: <200904012320.58551.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 01 April 2009, Sergei Shtylyov wrote:
> Since tf_{read|load}() methods of this driver have now become identical to their
> standard counterparts using MMIO accesses, there's no need to override those
> anymore...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
