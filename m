From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] tx493[89]ide: Remove big endian version of tx493[89]ide_tf_{load,read}
Date: Mon, 6 Apr 2009 22:58:19 +0200
Message-ID: <200904062258.20246.bzolnier@gmail.com>
References: <1239034146-3514-1-git-send-email-anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:43876 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbZDFVLh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 6 Apr 2009 17:11:37 -0400
In-Reply-To: <1239034146-3514-1-git-send-email-anemo@mba.ocn.ne.jp>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 06 April 2009, Atsushi Nemoto wrote:
> Now tx493[89]ide_tf_{load,read} do not contain word I/O operations.
> They are endian-free now.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

applied
