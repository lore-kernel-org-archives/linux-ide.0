From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 1/3] ide_in_drive_list(): accept NULL as the wildcard for firmware revision.
Date: Wed, 30 May 2007 22:43:52 +0200
Message-ID: <200705302243.52668.bzolnier@gmail.com>
References: <20070521145042.GA6957@redhat.com> <200705282141.42507.bzolnier@gmail.com> <7v4plw8ryk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:50035 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbXE3WWx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 May 2007 18:22:53 -0400
Received: by an-out-0708.google.com with SMTP id d31so775704and
        for <linux-ide@vger.kernel.org>; Wed, 30 May 2007 15:22:52 -0700 (PDT)
In-Reply-To: <7v4plw8ryk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Dave Jones <davej@redhat.com>

On Tuesday 29 May 2007, Junio C Hamano wrote:
> Earlier, the matching of (model,rev) in ide-dma black/white list
> handling was to consider "ALL" in the table to match any
> revision.  This makes NULL to be also an accepted wildcard, and
> changes the entries of tables in ide-dma.c to use NULL.
> 
> The code still accepts "ALL" as the wildcard, in order to keep
> any out-of-tree ide driver that feeds its own table that uses
> "ALL" as the wildcard to ide_in_drive_list() function from
> breaking.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

applied
