From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide-cd: remove obsolete seek optimization
Date: Thu, 16 Oct 2008 21:41:25 +0200
Message-ID: <200810162141.25832.bzolnier@gmail.com>
References: <200810152147.47534.bzolnier@gmail.com> <20081016054238.GB32756@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:5132 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758063AbYJPTw7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Oct 2008 15:52:59 -0400
Received: by yw-out-2324.google.com with SMTP id 9so47712ywe.1
        for <linux-ide@vger.kernel.org>; Thu, 16 Oct 2008 12:52:58 -0700 (PDT)
In-Reply-To: <20081016054238.GB32756@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Thursday 16 October 2008, Borislav Petkov wrote:
> On Wed, Oct 15, 2008 at 09:47:47PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > It doesn't make much sense nowadays and is problematic on some drives.
> 
> This is a big chunk, after all. We should do more hammering on it though, just
> to be sure.

yep, this is meant for .29
