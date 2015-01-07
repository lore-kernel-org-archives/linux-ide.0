From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] libata: Remove FIXME comment in atapi_eh_request_sense
Date: Wed, 7 Jan 2015 10:08:09 -0500
Message-ID: <20150107150809.GA4395@htj.dyndns.org>
References: <1420609492-19422-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:58159 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbbAGPIO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 7 Jan 2015 10:08:14 -0500
Content-Disposition: inline
In-Reply-To: <1420609492-19422-1-git-send-email-xerofoify@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Nicholas Krause <xerofoify@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 07, 2015 at 12:44:52AM -0500, Nicholas Krause wrote:
> Remove the FIXME comment in  atapi_eh_request_sense () asking whether
> memset of sense buffer is necessary.  The buffer may be partially or
> fully filled by the device.  We want it to be cleared.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>

Applied to libata/for-3.20.  Thanks.

-- 
tejun
