From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH resend 2/2] ide-h8300: remove custom tf_{read|load}() methods
Date: Thu, 2 Apr 2009 21:19:12 +0200
Message-ID: <200904022119.12898.bzolnier@gmail.com>
References: <200904012321.14661.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:44079 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759087AbZDBTgp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 2 Apr 2009 15:36:45 -0400
Received: by mail-bw0-f169.google.com with SMTP id 17so671388bwz.37
        for <linux-ide@vger.kernel.org>; Thu, 02 Apr 2009 12:36:43 -0700 (PDT)
In-Reply-To: <200904012321.14661.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Wednesday 01 April 2009, Sergei Shtylyov wrote:
> Since tf_{read|load}() methods of this driver have now become identical to their
> standard counterparts using I/O port accesses, there's no need to override those
> anymore...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
