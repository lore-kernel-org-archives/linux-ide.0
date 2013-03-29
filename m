From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH v2] [libata] Fix HDIO_DRIVE_CMD ioctl sense data check
Date: Fri, 29 Mar 2013 18:47:35 +0100
Message-ID: <20130329174735.GA23708@shrek.podlesie.net>
References: <1364576992-17598-1-git-send-email-gwendal@google.com>
 <1364577166-17930-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from shrek-wifi.podlesie.net ([93.179.225.50]:37160 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab3C2Rrj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Mar 2013 13:47:39 -0400
Content-Disposition: inline
In-Reply-To: <1364577166-17930-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: ronald645@gmail.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 29, 2013 at 10:12:46AM -0700, Gwendal Grignou wrote:
> commit 84a9a8cd9d0aa93c17e5815ab8a9cc4c0a765c63 changed the sense key
> used for returning task registers, but HDIO_DRIVE_CMD ioctl was
> not changed accordingly.
> 
> Tested: check that SMART ENABLE sent using HDIO_DRIVE_CMD returns 0
> instead of EIO.
> 
> Signed-off-by: Gwendal Grignou <gwendal@google.com>

Works for me. If you like you can add:

Reported-and-tested-by: Krzysztof Mazur <krzysiek@podlesie.net>

Krzysiek
