From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: remove stale ide.h "configuration options"
Date: Fri, 26 Oct 2007 23:33:06 +0200
Message-ID: <200710262333.06525.bzolnier@gmail.com>
References: <200710262329.17605.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:12472 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754604AbXJZV0o (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 17:26:44 -0400
Received: by nf-out-0910.google.com with SMTP id g13so894211nfb
        for <linux-ide@vger.kernel.org>; Fri, 26 Oct 2007 14:26:43 -0700 (PDT)
In-Reply-To: <200710262329.17605.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


noticed this after hitting the "Send" button:

On Friday 26 October 2007, Bartlomiej Zolnierkiewicz wrote:

> * OK_TO_RESET_CONTROLLER - always defined to 0

s/0/1/

[ the patch is OK, the mistake was only in the description ]
