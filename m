From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH 3/3] ide_in_drive_list(): "ALL" is not a wildcard anymore.
Date: Wed, 30 May 2007 22:47:26 +0200
Message-ID: <200705302247.26891.bzolnier@gmail.com>
References: <20070521145042.GA6957@redhat.com> <200705282141.42507.bzolnier@gmail.com> <7vsl9g7dd8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.244]:50062 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758441AbXE3WW4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 30 May 2007 18:22:56 -0400
Received: by an-out-0708.google.com with SMTP id d31so775707and
        for <linux-ide@vger.kernel.org>; Wed, 30 May 2007 15:22:55 -0700 (PDT)
In-Reply-To: <7vsl9g7dd8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org, Dave Jones <davej@redhat.com>

On Tuesday 29 May 2007, Junio C Hamano wrote:
> This removes the support to treat "ALL" as a wildcard for
> firmware revision.  This is made a separate patch, as it will
> break out-of-tree ide drivers that feed its own table that uses
> "ALL" as the wildcard to ide_in_drive_list().
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

applied
