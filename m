From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 4/5] ide-cd: shorten lines longer than 80 columns
Date: Thu, 28 Feb 2008 00:15:27 +0100
Message-ID: <200802280015.27990.bzolnier@gmail.com>
References: <1204136449-9490-1-git-send-email-petkovbb@gmail.com> <20080227221532.GB9545@gollum.tnic> <200802280001.43316.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:24671 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbYB0XAt (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 27 Feb 2008 18:00:49 -0500
Received: by ug-out-1314.google.com with SMTP id z38so6225ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 27 Feb 2008 15:00:48 -0800 (PST)
In-Reply-To: <200802280001.43316.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

On Thursday 28 February 2008, Bartlomiej Zolnierkiewicz wrote:

[...]

> [ IOW We are putting way too much time into these coding style fixes and as
>   the old code is replaced with the new one the coding style improves itself. ]

Just to clarify: by "these" I meant only ide-cd ones, i.e. we are beautifying
comments for code which is going to be heavily modified soon because of other
changes like ATAPI handling unification...
