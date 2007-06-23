From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: Stop mapping ROMs
Date: Sat, 23 Jun 2007 19:42:22 +0200
Message-ID: <200706231942.22325.bzolnier@gmail.com>
References: <20070622142252.2ec0d148@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:28896 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753676AbXFWRws (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 13:52:48 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1019618ugf
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 10:52:48 -0700 (PDT)
In-Reply-To: <20070622142252.2ec0d148@the-village.bc.nu>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-ide@vger.kernel.org

On Friday 22 June 2007, Alan Cox wrote:
> Various old IDE drivers go mapping ROM devices for no apparent reason and
> without using the ROM mapping API we now have. They don't actually use
> the ROM they map and the new libata drivers are happy without it being
> mapped so rather than port them lets just junk it for the next -rc1.
> 
> Signed-off-by: Alan Cox <alan@redhat.com>

applied
