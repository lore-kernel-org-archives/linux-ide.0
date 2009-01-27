From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 2/3] ide: improve debugging scheme
Date: Tue, 27 Jan 2009 16:22:47 +0100
Message-ID: <200901271622.47400.bzolnier@gmail.com>
References: <1233002440-4325-1-git-send-email-petkovbb@gmail.com> <1233002440-4325-2-git-send-email-petkovbb@gmail.com> <20090127061906.GA22179@gollum.tnic>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:29507 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbZA0PZQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Jan 2009 10:25:16 -0500
In-Reply-To: <20090127061906.GA22179@gollum.tnic>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Tuesday 27 January 2009, Borislav Petkov wrote:
> On Mon, Jan 26, 2009 at 09:40:39PM +0100, Borislav Petkov wrote:
> > and more specifically, push __func__ into debug
> > macro thus making ide_debug_log() calls shorter and more readable.
> 
> Ups, sorry, I left the debug on :). Take better that one instead.
> 
> ---
> From: Borislav Petkov <petkovbb@gmail.com>
> Date: Fri, 2 Jan 2009 13:34:47 +0100
> Subject: [PATCH 2/3] ide: improve debugging scheme
> 
> and more specifically, push __func__ into debug
> macro thus making ide_debug_log() calls shorter and more readable.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
