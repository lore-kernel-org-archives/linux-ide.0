From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-cd: replace ntohs with generic byteorder macro be16_to_cpu
Date: Fri, 8 Feb 2008 21:39:16 +0100
Message-ID: <200802082139.16877.bzolnier@gmail.com>
References: <20080208062903.GA20018@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.224]:15506 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbYBHVDI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Feb 2008 16:03:08 -0500
Received: by qb-out-0506.google.com with SMTP id e11so6434904qbe.15
        for <linux-ide@vger.kernel.org>; Fri, 08 Feb 2008 13:03:05 -0800 (PST)
In-Reply-To: <20080208062903.GA20018@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 08 February 2008, Borislav Petkov wrote:
> commit d41c6bc739e7ea7880f7f5983a9694f2e0214d92
> Author: Borislav Petkov <petkovbb@gmail.com>
> Date:   Fri Feb 8 07:25:44 2008 +0100
> 
>     ide-cd: replace ntohs with generic byteorder macro be16_to_cpu
>     
>     Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
