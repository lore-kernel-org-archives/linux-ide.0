From: "Boris Petkov" <petkovbb@googlemail.com>
Subject: Re: [8/17] ide-cd: use bcd2bin/bin2bcd
Date: Fri, 8 Aug 2008 18:56:22 +0200
Message-ID: <9ea470500808080956m23f59966nb9b1955e174d157d@mail.gmail.com>
References: <20080808163446.GO14495@cs181140183.pp.htv.fi>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:61632 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbYHHQ4X (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 8 Aug 2008 12:56:23 -0400
Received: by wf-out-1314.google.com with SMTP id 27so1797405wfd.4
        for <linux-ide@vger.kernel.org>; Fri, 08 Aug 2008 09:56:22 -0700 (PDT)
In-Reply-To: <20080808163446.GO14495@cs181140183.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>

On Fri, Aug 8, 2008 at 6:34 PM, Adrian Bunk <bunk@kernel.org> wrote:
> This patch changes ide-cd to use the new bcd2bin/bin2bcd functions
> instead of the obsolete BCD2BIN/BIN2BCD macros.
>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Acked-by: Borislav Petkov <petkovbb@gmail.com>

[.. ]

-- 
Regards/Gruss,
Boris.
