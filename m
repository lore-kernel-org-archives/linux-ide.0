From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/2] ide: inline SELECT_DRIVE()
Date: Fri, 20 Mar 2009 20:03:05 +0100
Message-ID: <200903202003.05283.bzolnier@gmail.com>
References: <200903191835.13048.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:49492 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757542AbZCTTHB (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Mar 2009 15:07:01 -0400
Received: by mail-fx0-f158.google.com with SMTP id 2so1031058fxm.37
        for <linux-ide@vger.kernel.org>; Fri, 20 Mar 2009 12:07:00 -0700 (PDT)
In-Reply-To: <200903191835.13048.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Thursday 19 March 2009, Sergei Shtylyov wrote:
> Since SELECT_DRIVE() has boiled down to a mere dev_select() method call, it now
> makes sense to just inline it...
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

applied
