From: Erwan Velu <erwanaliasr1@gmail.com>
Subject: Question about the maximum value for unload_head
Date: Wed, 02 Jun 2010 22:46:59 +0200
Message-ID: <4C06C343.3050903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33475 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758027Ab0FBUrE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jun 2010 16:47:04 -0400
Received: by wyi11 with SMTP id 11so2222841wyi.19
        for <linux-ide@vger.kernel.org>; Wed, 02 Jun 2010 13:47:02 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hey folks,

I'm in an industrial situation where my Linux system could be strongly
shacked for some minutes.
I'm able to detect this situation and so, to protect my hard drive, I
park its heads by using the unload_heads feature.
I have nothing to say more than it works sooooo good ! But I saw there
is a limitation to 30sec as #define MAX_PARK_TIMEOUT 30000

That mean in my case that I have to manage a stupid script that have to
retrigger the unload_heads every 30sec. That's stupid script and I
wonder if it could be possible to get rid of it. Why is there such
limitation. Why 30sec ?

Could it be possible to increase this value ?

Thanks for your inputs,
Erwan Velu

