From: Greg Freemyer <greg.freemyer@gmail.com>
Subject: Re: Bug: Resume with Host Protected Area
Date: Tue, 19 Apr 2005 17:20:23 -0400
Message-ID: <87f94c370504191420d2f5c32@mail.gmail.com>
References: <4265640B.5060402@hathawaymix.org>
Reply-To: Greg Freemyer <greg.freemyer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.204]:13711 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261692AbVDSVU0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 19 Apr 2005 17:20:26 -0400
Received: by wproxy.gmail.com with SMTP id 68so2232662wra
        for <linux-ide@vger.kernel.org>; Tue, 19 Apr 2005 14:20:24 -0700 (PDT)
In-Reply-To: <4265640B.5060402@hathawaymix.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Shane Hathaway <shane@hathawaymix.org>
Cc: linux-ide@vger.kernel.org

IMHO, if you are going to put live data in the HPA, you really should
just kill the HPA permanently not depend on Linux to do a volitile
reset on every reboot/resume.

See setmax at http://www.win.tue.nl/~aeb/linux/setmax.c 

You can compile that and use it to permanently modify your HPA setting.

use the -m (--max) option to permanently modify your HPA setting.

You can also use -d to make volitile changes.  IIRC, volitile changes
to are reset on every power cycle of the drive.

HTH,
Greg
-- 
Greg Freemyer

On 4/19/05, Shane Hathaway <shane@hathawaymix.org> wrote:
> Until today, I haven't been able to reliably put my ThinkPad T41 to
> sleep.  After resuming, it generated lots of disk errors, and only a
> reboot would bring it back to sanity.
> 
> Today I finally realized what's going on.  This laptop has a 3.5 GB
> protected area at the end of the drive.  Linux disables the protection
> on bootup (making the whole drive available), but the laptop apparently
> re-enables the protection during the sleep cycle.  So I moved my
> partitions out of the protected area and now the laptop finally resumes
> correctly.  Yehaw!
> 
> The bugfix should be simple: call idedisk_check_hpa() during resume.
> 
> I'm not subscribed to this list, so please CC me on replies.
> 
> Shane
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Greg Freemyer
The Norcross Group
Forensics for the 21st Century
