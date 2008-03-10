From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/4] ide-tape remove pipeline speed/control calculations
Date: Tue, 11 Mar 2008 00:25:42 +0100
Message-ID: <200803110025.42437.bzolnier@gmail.com>
References: <1205082632-3418-1-git-send-email-petkovbb@gmail.com> <1205082632-3418-4-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:52219 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230AbYCJXNC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 10 Mar 2008 19:13:02 -0400
Received: by fg-out-1718.google.com with SMTP id e21so2142905fga.17
        for <linux-ide@vger.kernel.org>; Mon, 10 Mar 2008 16:13:01 -0700 (PDT)
In-Reply-To: <1205082632-3418-4-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, Borislav Petkov <petkovbb@gmail.com>

On Sunday 09 March 2008, Borislav Petkov wrote:
> Pipeline handling calculations in idetape_calculate_speeds() can
> go since they do not have any effect on other functionality besides:
> 
> 1. info is only being exported through /proc as a read-only item
> (controlled_pipeline_head_speed, uncontrolled_pipeline_head_speed)
> 
> 2. used in idetape_restart_speed_control() which, in turn, is unrelated to
> other code
> 
> 3. used only for pipeline frames number accounting (tape->pipeline_head),
> also unused elsewhere.
> 
> 4.some variables are:
>         only written to: tape->buffer_head;
>         unused: tape->tape_head, tape->last_tape_head
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
