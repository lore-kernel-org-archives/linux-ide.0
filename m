From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/5] storage-fixup: make a quiet/silent mode work
Date: Wed, 12 Nov 2008 14:27:58 +0900
Message-ID: <491A695E.8050501@kernel.org>
References: <200810290910.25324.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53142 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbYKLF2F (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Nov 2008 00:28:05 -0500
In-Reply-To: <200810290910.25324.kel@otaku42.de>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Kel Modderman <kel@otaku42.de>
Cc: linux-ide@vger.kernel.org

Kel Modderman wrote:
> Add a quiet mode. Remove the seemingly unused sact variable.

Modified so that execution header is printed on !quiet.  (the
"storage-fixup: RULE: executing ..." line and use "eval $act >
/dev/null" for quiet mode instead and revive sact (I'm planning on using
it for drives to issue warning messages which we can't do much about).

-- 
tejun
