From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: ide-cd.c fix sparse endianness warnings
Date: Tue, 8 Jul 2008 22:56:43 +0200
Message-ID: <200807082256.43501.bzolnier@gmail.com>
References: <1215128085.16647.40.camel@brick> <20080706072540.GA31524@gollum.tnic> <200807081958.29405.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:18425 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbYGHU6g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 8 Jul 2008 16:58:36 -0400
Received: by mu-out-0910.google.com with SMTP id w8so842122mue.1
        for <linux-ide@vger.kernel.org>; Tue, 08 Jul 2008 13:58:34 -0700 (PDT)
In-Reply-To: <200807081958.29405.bzolnier@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: petkovbb@gmail.com
Cc: Harvey Harrison <harvey.harrison@gmail.com>, linux-ide <linux-ide@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Tuesday 08 July 2008, Bartlomiej Zolnierkiewicz wrote:

> BTW ide-cd & co can as well use kernel typedefs (without "__" prefix)

Please disregard this comment w.r.t. annotations
(somehow I was thinking about __u8 in ide-cd.h instead).
