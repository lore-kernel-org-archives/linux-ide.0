From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 0/2] ide-tape: fix flags
Date: Fri, 5 Jun 2009 20:34:06 +0200
Message-ID: <200906052034.06668.bzolnier@gmail.com>
References: <1243926308-32385-1-git-send-email-petkovbb@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:38868 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbZFESxT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 5 Jun 2009 14:53:19 -0400
In-Reply-To: <1243926308-32385-1-git-send-email-petkovbb@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Borislav Petkov <petkovbb@googlemail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 02 June 2009 09:05:06 Borislav Petkov wrote:
> Hi Bart,
> 
> those fix a stupid flags misuse that got spotted by Jiri Slaby. Please
> pay special attention to the first patch. FWIW, those can go as hot
> fixes right away and we might catch 30-rc8 since it's not out yet.

The problem is that patches seem to be against ide-2.6.git/for-next...
