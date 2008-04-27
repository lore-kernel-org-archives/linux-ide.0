From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/6] IDE: ide-cd: fix test unsigned var < 0
Date: Sun, 27 Apr 2008 20:32:47 +0200
Message-ID: <200804272032.47939.bzolnier@gmail.com>
References: <48055F1A.9020706@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:25296 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761819AbYD0TyP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Apr 2008 15:54:15 -0400
Received: by fg-out-1718.google.com with SMTP id l27so4628225fgb.17
        for <linux-ide@vger.kernel.org>; Sun, 27 Apr 2008 12:54:14 -0700 (PDT)
In-Reply-To: <48055F1A.9020706@tiscali.nl>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Roel Kluin <12o3l@tiscali.nl>
Cc: linux-ide@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Borislav Petkov <petkovbb@gmail.com>

On Wednesday 16 April 2008, Roel Kluin wrote:
> Is this the right fix in this case?
> ---
> valid is unsigned and cannot be below 0.,
>     
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

applied
