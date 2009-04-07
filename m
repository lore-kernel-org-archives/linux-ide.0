From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/2] ide-cd: reverse NOT_READY sense key logic
Date: Tue, 7 Apr 2009 20:25:25 +0200
Message-ID: <200904072025.30587.bzolnier@gmail.com>
References: <1238922962-19727-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:45110 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761485AbZDGVky (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 7 Apr 2009 17:40:54 -0400
In-Reply-To: <1238922962-19727-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Sunday 05 April 2009 11:16:01 Borislav Petkov wrote:
> Make the case of flushing the drive's cache explicit.
> 
> There should be no functional change resulting from this patch.
> 
> Signed-off-by: Borislav Petkov <petkovbb@gmail.com>

applied
