From: Cyber Source <peter@cybersource.us>
Subject: patch file for ahci.c
Date: Wed, 09 Sep 2009 12:15:38 -0400
Message-ID: <4AA7D4AA.8050903@cybersource.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ns1.thecybersource.com ([64.65.249.35]:37062 "EHLO
	email.thecybersource.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753349AbZIIQ3M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 9 Sep 2009 12:29:12 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

Hello Jeff,
  I was hoping you could help me with a patch that I need for the ahci.c 
file. I am specifically referring to this, it appears to be the fix that 
I need. 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bd17243a84632465f5403bc9eb8b4831bd67e582
I am having a hard time implementing this change. I don't see where this 
patch can be download and or what kernel it's been patched against. I 
see the diffs but again, don't know what the original file is from. I 
have downloaded the full 2.6.30 kernel and then applied the full kernel 
patch 2.6.31-rc9 in hopes that the patch/change would have been 
included, but it wasn't, still had the soft-reset error. I then tried to 
download the b/drivers/ata/ahci.c file from the git.kernel link above 
and did a diff against the one from the above kernel and patch and then 
it failed upon compile when it hit that file saying error on lines 1604 
and 1605 expecting a ";'" before "if". Could you please help me with 
this. This is for a laptop and I cannot change out the controller. 
Thanks for any help, Peter*
*
-- 
cybersource.us
115 Richfield Road
Williamsville, New York 14221
716-553-8525
