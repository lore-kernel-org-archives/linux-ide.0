From: Peter Wu <peter-VTkQYDcBqhK7DlmcbJSQ7g@public.gmane.org>
Subject: blkdiscard vs hdparm for erasing a SSD?
Date: Wed, 15 Oct 2014 15:12:42 +0200
Message-ID: <2523736.cvg5kvG8qa@al>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: util-linux-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, util-linux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-ide@vger.kernel.org

Hi,

Recent versions of util-linux have a blkdiscard program. How does this compare
to the --security-erase option of hdparm? The goal is to erase the contents of
an previously used SSD to improve performance.

Is the command `blkdiscard -s /dev/sdd` equivalent to the instructions listed on
https://ata.wiki.kernel.org/index.php/ATA_Secure_Erase?
-- 
Kind regards,
Peter
https://lekensteyn.nl

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
