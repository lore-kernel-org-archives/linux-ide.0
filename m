From: David Pye <dmp@davidmpye.dyndns.org>
Subject: Using the WIN_SECURITY_* ioctls
Date: Sat, 29 May 2004 14:23:01 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405291423.01917.dmp@davidmpye.dyndns.org>
Reply-To: dmp@davidmpye.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 81-86-127-215.dsl.pipex.com ([81.86.127.215]:15115 "EHLO
	titanium.localdomain") by vger.kernel.org with ESMTP
	id S264836AbUE2NXE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 29 May 2004 09:23:04 -0400
Received: from platinum ([10.0.0.2])
	by titanium.localdomain with esmtp (Exim 3.35 #1 (Debian))
	id 1BU3oR-0004rI-00
	for <linux-ide@vger.kernel.org>; Sat, 29 May 2004 14:23:47 +0100
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've been banging my head against this little problem for some time, trying to 
produce a small tool to manipulate the security settings of a hard disk with 
Linux.  The disks in question are locked with a user password, at maximum 
security level.

I've got a bios which automatically unlocks the disk at boot, but I'm not able 
to DISABLE the password from then on. I also cannot unlock manually disks, 
using the correct password.

However I try to do it, I'm not able to get the ioctls right, it seems, and 
the hard disk refuses to speak to me again, until a power cycle.  I know what 
the password is, it's just that I dont seem to be able to send it.

Could anybody tell me if there's anything obvious wrong or missing with the 
following code snippet?  (The hdd is in the unlocked state at the time).

int hdd_disable_pass(char *device,char *password) {
        unsigned char args[4+512] = { WIN_SECURITY_DISABLE, 0, 0, 0, 0, };
        unsigned char *data = &args[4];
        unsigned char status;
        int dev = open(device,O_RDONLY);
        memset(data,0,512);
        memcpy(&data[2], password, 20);
        if(ioctl(dev,HDIO_DRIVE_TASK,args)) {
                printf("HDD SECURITY DISABLE PASSWORD command failed\n");
                close(dev);
                return 0;
        }
        close(dev);
        return 1;
}

I've spent a rather unsatisfying few days googling, and looking for any 
documents or example tools using the security ioctls, and have thus far 
failed to find anything. 

The only thing I'm slightly curious about is that in 
<kernel>/include/linux/hdreg.h, it says above the security ioctls:

        /* SET_FEATURES 0x22 or 0xDD */
#define WIN_FLUSH_CACHE_EXT             0xEA /* 48-Bit */
#define WIN_IDENTIFY                    0xEC /* ask drive to identify itself    
*/
#define WIN_MEDIAEJECT                  0xED
#define WIN_IDENTIFY_DMA                0xEE /* same as WIN_IDENTIFY, but DMA 
*/
#define WIN_SETFEATURES                 0xEF /* set special drive features */
#define EXABYTE_ENABLE_NEST             0xF0
#define WIN_SECURITY_SET_PASS           0xF1
#define WIN_SECURITY_UNLOCK             0xF2
#define WIN_SECURITY_ERASE_PREPARE      0xF3
#define WIN_SECURITY_ERASE_UNIT         0xF4
#define WIN_SECURITY_FREEZE_LOCK        0xF5
#define WIN_SECURITY_DISABLE            0xF6

Does the SET_FEATURES apply to the security features, and if so, is it 
something I need to set, before I attempt the WIN_SECURITY_DISABLE?

hdreg.h also mentions the following subcommands, but I'm unsure as to whether 
I need to send these in addition to WIN_SECURITY_DISABLE, and if so, quite 
where to put them.

/* WIN_SECURITY sub-commands */

#define SECURITY_SET_PASSWORD           0xBA
#define SECURITY_UNLOCK                 0xBB
#define SECURITY_ERASE_PREPARE          0xBC
#define SECURITY_ERASE_UNIT             0xBD
#define SECURITY_FREEZE_LOCK            0xBE
#define SECURITY_DISABLE_PASSWORD       0xBF

Any pointers or advice would be very greatfully received!

Many thanks,

David Pye
