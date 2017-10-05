From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ahci: Convert timers to use timer_setup()
Date: Thu, 5 Oct 2017 07:21:24 -0700
Message-ID: <20171005142124.GT3301751@devbig577.frc2.facebook.com>
References: <20171005005417.GA23922@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:56137 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdJEOV2 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 5 Oct 2017 10:21:28 -0400
Content-Disposition: inline
In-Reply-To: <20171005005417.GA23922@beast>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Wed, Oct 04, 2017 at 05:54:17PM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list pointer to
> all timer callbacks, switch to using the new timer_setup() and from_timer()
> to pass the timer pointer explicitly. Adds a pointer back to link
> structure.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-ide@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route together with other timer patches.

Thanks.

-- 
tejun
