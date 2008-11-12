From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/5] storage-fixup: fix typo of configuration filename
Date: Wed, 12 Nov 2008 14:26:22 +0900
Message-ID: <491A68FE.2030906@kernel.org>
References: <200810290909.29583.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53070 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbYKLF0c (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Nov 2008 00:26:32 -0500
In-Reply-To: <200810290909.29583.kel@otaku42.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kel Modderman <kel@otaku42.de>
Cc: linux-ide@vger.kernel.org

Kel Modderman wrote:
> Fix spelling of storage-fixup.conf in storage-fixup script header.
> 
> Signed-off-by: Kel Modderman <kel@otaku42.de>
> ---
> --- a/storage-fixup
> +++ b/storage-fixup
> @@ -6,10 +6,10 @@
>  # to adjust ATA APM setting.  Some laptop BIOSen set this value too
>  # aggressively causing frequent head unloads which can kill the drive
>  # quickly.  This script should be called during boot and resume.  It
> -# examines rules from /etc/stroage-fixup.conf and executes matching
> +# examines rules from /etc/storage-fixup.conf and executes matching
>  # commands.
>  #
> -# In stroage-fixup.conf, empty lines and lines starting w/ # are
> +# In storage-fixup.conf, empty lines and lines starting w/ # are
>  # ignored.  Each line starts with rule, dmi, ata or act.
>  #
>  # rule RULENAME

applied

-- 
tejun
