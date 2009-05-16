From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] icside: register second channel of version 6 PCB
Date: Sat, 16 May 2009 18:55:32 +0200
Message-ID: <200905161855.32951.bzolnier@gmail.com>
References: <200905152008.29452.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:63422 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577AbZEPTPh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 May 2009 15:15:37 -0400
Received: by ewy24 with SMTP id 24so3209970ewy.37
        for <linux-ide@vger.kernel.org>; Sat, 16 May 2009 12:15:37 -0700 (PDT)
In-Reply-To: <200905152008.29452.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linux-ide@vger.kernel.org

On Friday 15 May 2009 18:08:29 Sergei Shtylyov wrote:
> The second IDE channel of version 6 PCB is not being registered anymore since
> the commit 48c3c1072651922ed153bcf0a33ea82cf20df390 (ide: add struct ide_host
> (take 3)).
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

thanks, applied
