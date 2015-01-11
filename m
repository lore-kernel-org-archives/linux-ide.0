From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] ata: libata-core: Remove unused function
Date: Sun, 11 Jan 2015 11:55:01 -0500
Message-ID: <20150111165501.GG25319@htj.dyndns.org>
References: <1420986421-18686-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:57093 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbbAKQzF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jan 2015 11:55:05 -0500
Content-Disposition: inline
In-Reply-To: <1420986421-18686-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jan 11, 2015 at 03:27:01PM +0100, Rickard Strandqvist wrote:
> Remove the function ata_do_simple_cmd() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Applied to libata/for-3.20.  Thanks.

-- 
tejun
