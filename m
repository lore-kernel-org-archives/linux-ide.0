From: Andy Warner <andyw@pobox.com>
Subject: Re: libata problems with 66Mhz Promise SATA150 TX4
Date: Wed, 15 Sep 2004 08:08:12 -0500
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040915080812.A7683@florence.linkmargin.com>
References: <m34qm13m8h.fsf@zathras.nivin.org> <41473287.7050101@epita.fr> <20040914191851.A7263@florence.linkmargin.com> <20040915090212.GA3493@hwi.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ms-smtp-04.rdc-kc.rr.com ([24.94.166.116]:22172 "EHLO
	ms-smtp-04.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S266117AbUIONKF (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Sep 2004 09:10:05 -0400
Content-Disposition: inline
In-Reply-To: <20040915090212.GA3493@hwi.epita.fr>; from bevand_m@epita.fr on Wed, Sep 15, 2004 at 11:02:12AM +0200
List-Id: linux-ide@vger.kernel.org
To: Marc Bevand <bevand_m@epita.fr>
Cc: linux-ide@vger.kernel.org

Marc Bevand wrote:
> Andy Warner wrote:
> | [...]
> | I'm observing a lower throughput than that, though ~60MB/s; so I'm
> | going to check to see if there is something else throttling
> | performance, below the point of failure.
> 
> Personally, I am using a blocksize of 32k with 'dd' in order to reach
> 215 MB/s, and I set the readahead to 256 on all the disks:
> 
>   $ blockdev --setra 256 /dev/sdX
> 
> To satisfy my curiosity, could you sent me an excerpt of 'vmstat 1' while
> stressing your disks like this ? Thanks.

I reconfigured the system so the TX4 was the only adapter on
the 100MHz PCI-X bus, and re-ran the tests - I'm now seeing ~200MB/s
with dd (bs=1M) and ~110MB/s with sg_utils. It ran for 9 hours
overnight without error.

Here's the vmstat output you requested.

First using dd to read the disks:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  4      0 1067520 856456  71224    0    0   225     3   18   166  0 20 50 30
 1  3      0 1067584 856360  71320    0    0 195320   188 2845  3685  0 23 49 29
 1  3      0 1066640 857356  71364    0    0 196352     4 2806  3703  0 22 51 26
 3  2      0 1066688 857252  71208    0    0 194688    32 2781  3633  0 23 52 25
 1  3      0 1067712 856380  71040    0    0 195712     0 2810  3667  0 23 51 26
 0  4      0 1066624 857392  71068    0    0 190976    16 2762  3564  0 23 51 27
 0  4      0 1067840 856172  71248    0    0 196864     0 2825  3696  0 23 49 28
 4  2      0 1066368 857496  70964    0    0 193792    36 2770  3613  0 22 52 26
 1  4      0 1067648 856388  71292    0    0 195200     0 2772  3586  0 23 53 25
 1  3      0 1066752 857348  71112    0    0 193832    44 2793  3596  0 22 52 26
 1  4      0 1068104 855976  71184    0    0 196952    32 2846  3729  0 23 45 32
 0  4      0 1067272 856848  71092    0    0 197120     0 2812  3689  0 24 47 30
 3  2      0 1066696 857392  71328    0    0 195368    24 2806  3675  0 23 48 30
 0  4      0 1067208 856880  71060    0    0 195160     0 2801  3688  0 23 48 29
 1  3      0 1066364 857732  71248    0    0 195584     4 2835  3695  0 23 44 33
 2  3      0 1067656 856496  71184    0    0 196864     0 2899  3831  0 24 37 39
 2  3      0 1067656 856464  70956    0    0 195200     0 2833  3708  0 24 41 35
 0  4      0 1066784 857312  71148    0    0 194688    24 2840  3718  0 24 42 34
 1  3      0 1067672 856516  71164    0    0 195512     0 2860  3717  0 24 40 37
 3  2      0 1066584 857572  71148    0    0 197448     0 2814  3706  0 24 48 28
 1  3      0 1067608 856520  71160    0    0 195840     0 2812  3644  0 23 49 28

Now using sg_utils to read the disks:
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 1927480   1752  74688    0    0   195     3   63   221  0 20 50 30
 0  0      0 1927480   1752  74688    0    0     0     0 10576 18441  2  8 90  0
 0  0      0 1927480   1752  74688    0    0     0     0 10700 18677  2  8 90  0
 0  0      0 1927480   1752  74688    0    0     0     0 10668 18609  2  8 90  0
 0  0      0 1927480   1752  74688    0    0     0     0 10770 18773  1  9 89  0
 0  1      0 1927480   1760  74680    0    0     0    40 10753 18747  2  8 90  0
 2  0      0 1927480   1760  74680    0    0     0     0 10682 18605  2  9 90  0
 2  0      0 1927480   1760  74680    0    0     0     0 10571 18342  2  9 88  0
 0  0      0 1927480   1760  74680    0    0     0     0 10618 18515  2  8 90  0
 0  0      0 1927480   1760  74680    0    0     0     0 10564 18311  2  9 90  0
 0  0      0 1927480   1760  74680    0    0     0     0 10764 18736  2  9 89  0
 1  0      0 1927480   1760  74680    0    0     0     0 10640 18513  2  9 89  0
 0  0      0 1927480   1760  74680    0    0     0     0 10836 18908  2  9 89  0
 0  0      0 1927480   1760  74680    0    0     0     0 10795 18805  1  8 90  0
 0  0      0 1927480   1760  74680    0    0     0     0 10676 18616  2  8 90  0
 1  0      0 1927480   1760  74680    0    0     0     0 10529 18346  2  8 89  0
 1  0      0 1927480   1760  74680    0    0     0     0 10727 18728  2  8 90  0
 0  0      0 1927480   1760  74680    0    0     0     0 10627 18534  2  9 90  0
 0  0      0 1927480   1760  74680    0    0     0     0 10676 18640  2  8 90  0

-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
