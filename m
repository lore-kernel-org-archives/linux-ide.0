From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [2,6 patch] make ide-iops.c:SELECT_MASK() static
Date: Tue, 6 May 2008 17:59:03 +0200
Message-ID: <200805061759.04076.bzolnier@gmail.com>
References: <20080505182139.GD17139@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:22056 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbYEFQEm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 May 2008 12:04:42 -0400
Received: by fg-out-1718.google.com with SMTP id 19so498111fgg.17
        for <linux-ide@vger.kernel.org>; Tue, 06 May 2008 09:04:40 -0700 (PDT)
In-Reply-To: <20080505182139.GD17139@cs181133002.pp.htv.fi>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 05 May 2008, Adrian Bunk wrote:
> SELECT_MASK() can now become static.
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

applied
