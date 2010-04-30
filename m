From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 15884] New: cd-burning reduces other simultaneous IO
 performance
Date: Fri, 30 Apr 2010 15:42:11 GMT
Message-ID: <bug-15884-11633@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from demeter.kernel.org ([140.211.167.39]:40848 "EHLO
	demeter.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932834Ab0D3RbC (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Apr 2010 13:31:02 -0400
Received: from demeter.kernel.org (localhost.localdomain [127.0.0.1])
	by demeter.kernel.org (8.14.3/8.14.3) with ESMTP id o3UFgCcR018047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Fri, 30 Apr 2010 15:42:13 GMT
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=15884

           Summary: cd-burning reduces other simultaneous IO performance
           Product: IO/Storage
           Version: 2.5
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: danielhollocher@gmail.com
                CC: danielhollocher@gmail.com
        Regression: No


Hey folks, I having a problem similar to one of the commenters on bug #13347. 
But that report in general is kinda confusing, and it seemed like the devs had
trouble understanding the issue.  One possibility is that the issue that I and
the commenter have may not be the same as the original bug in 13347.  I also
have a reliable way to trigger the bug in a bad way, just burn a cd.  So, I am
posting this new bug report.

Basically, my system feels a bit sluggish, and when I try to burn a CD, my
system becomes unusable.  I will explain in further detail after I describe my
setup.

My system:
ASUS P5B motherboard
a 500GB SATA drive connect through one of the SATA ports (sda)
an 60 GB PATA drive, connect as the master on the single Jmicron IDE (sdb)
a Verbatim CD-RW, connected on the slave of the same IDE

My OSs:
I have windows on the first partition of sdb
I have my main Ubuntu install on another partition of sdb (linux version
2.6.31)
I have a testing Ubuntu install on one of the partitions of sda (linux version
2.6.32)

Now, I have always noticed that my main felt a bit sluggish.  Windows felt
faster, and I would just chock it up to "weirdness".  I suspect that I'm
getting poor performance in general, but it really shows up when I'm burning a
disk.  My computer becomes unusable, as any IO operations no matter how small
end up having several second wait times.  I have to be careful just moving a
window around.  I tested on windows, and I can burn a disk, defrag the drive,
and open open office all at the same time.  The system is correspondingly
sluggish, but that is to be expected.  I get no lockups like I do on linux.  I
have had this issue for the life of the computer, accross several ubuntu
releases.  I have also tester a kernel from the ubuntu mainline ppa of version
2.6.33.  

As you can see, I haven't tried downloading the source code and compiling
myself yet.  I don't know if that makes a difference.

Here are some illuminating tests.  I was booted on the nice drive (sda) with
the testing install.

$ sudo hdparm -tT /dev/sdb
/dev/sdb:
 Timing cached reads:   2146 MB in  2.00 seconds = 1073.83 MB/sec
 Timing buffered disk reads:  128 MB in  3.03 seconds =  42.27 MB/sec
$ sudo hdparm -tT /dev/sda
/dev/sda:
 Timing cached reads:   2308 MB in  2.00 seconds = 1154.93 MB/sec
 Timing buffered disk reads:  284 MB in  3.01 seconds =  94.50 MB/sec


I started the burn process, and caught this test while it was erasing the CDRW:
/dev/sdb:
 Timing cached reads:   2294 MB in  2.00 seconds = 1147.90 MB/sec
 Timing buffered disk reads:    2 MB in 88.41 seconds =  23.16 kB/sec


During the burn process, which displays a speed of 0.7MB/s:
$ sudo hdparm -tT /dev/sdb
/dev/sdb:
 Timing cached reads:   908 MB in  2.00 seconds = 453.90 MB/sec
 Timing buffered disk reads:    6 MB in  3.87 seconds =   1.55 MB/sec
$ sudo hdparm -tT /dev/sda
/dev/sda:
 Timing cached reads:   2254 MB in  2.00 seconds = 1127.28 MB/sec
 Timing buffered disk reads:  282 MB in  3.00 seconds =  93.98 MB/sec


So while burning on the slave of the IDE, I loose almost all my "buffered disk
read" performance for the master IDE channel!  Does that make sense?  If I burn
a cd at 1MB/s, it should not take up 41MB/s bandwidth.

-- 
Configure bugmail: https://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are watching the assignee of the bug.
