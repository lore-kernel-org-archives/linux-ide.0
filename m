From: Peter Rabbitson <rabbit+list@rabbit.us>
Subject: Kernel option to disable TRIM/discard system-wide?
Date: Mon, 23 May 2016 23:01:26 +0200
Message-ID: <57436FA6.1010801@rabbit.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mujunyku.leporine.io ([113.212.96.195]:54487 "EHLO
	mujunyku.leporine.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbcEWVKQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 23 May 2016 17:10:16 -0400
Received: from [10.0.13.10] (unknown [10.0.13.10])
	by mujunyku.leporine.io (Postfix) with ESMTP id F317FF41DA
	for <linux-ide@vger.kernel.org>; Mon, 23 May 2016 21:01:27 +0000 (UTC)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello!

I have looked through the archives, but can not find anything even 
remotely related to the subject:

I want to disable trim on my system for good - yet there seems to be no 
kernel boot parameter for this.

My rationale is simple: I want best data integrity guarantees, followed 
by better battery-life + mechanical robustness (I throw my laptop around 
a lot), and only last am I concerned about performance.

There seem to be a new TRIM-related bug discovered every couple months 
for quite some time now. Combined with the "metadata leak via dm-crypt" 
makes it a no-brainer decision that I want to avoid TRIM system-wide.

I currently have my sytsem configured properly, but I am concerned a 
future OS upgrade will introduce some well meaning cron-job or something 
along these lines that will re-enable discards without me ever noticing.

Is there a boot parameter I can hard-code for forward-compatible peace 
of mind?

Thank you!
