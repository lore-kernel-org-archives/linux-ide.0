From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Fix for broken SB600 64 bit DMA issue - generic way
Date: Sun, 16 Aug 2009 21:10:05 +0900
Message-ID: <4A87F71D.6070909@kernel.org>
References: <4A84CC8A.7000103@kernel.org> <1250279686-5209-1-git-send-email-sbodomerle@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42763 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728AbZHPMKZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 16 Aug 2009 08:10:25 -0400
In-Reply-To: <1250279686-5209-1-git-send-email-sbodomerle@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sandor Bodo-Merle <sbodomerle@gmail.com>
Cc: linux-ide@vger.kernel.org, Shane.Huang@amd.com

Hello, Sandor, Shane.

I redid this patch with proper dmi_get_date() implementation.  Your
code was fine but the custom parsing looked a tad bit too
out-of-place.  :-(

  http://thread.gmane.org/gmane.linux.ide/42360

It would be great if you can find out whether more recent BIOSen don't
have the issue.  It would be best if you can find exactly which BIOS
revision fixes the problem by stepping through each update but if you
don't have the time then just testing the latest one should do for the
time being.

Thanks.

-- 
tejun
