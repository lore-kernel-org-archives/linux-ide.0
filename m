From: com bio <combiofriends@yahoo.com>
Subject: unable to connect.. tcpdump output...
Date: Wed, 12 Oct 2005 01:30:10 -0700 (PDT)
Message-ID: <20051012083010.91162.qmail@web32802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from web32802.mail.mud.yahoo.com ([68.142.206.32]:16718 "HELO
	web32802.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932120AbVJLIaO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Oct 2005 04:30:14 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: RealTime_Systems@yahoogroups.com

Hello,
  I am unable to connect from a remote machine to my
machine throught ssh. My machine runs fedora core 3.
and no firewall is running in my machine. The default
firewall in fedora has been disabled. SE linux has
been disabled. SSHD is running in my machine. I had
pasted the tcpdump output here. I would like someone
to diagnise this. Thanks

   1.
       
   2.
      tcpdump: verbose output suppressed, use -v or
-vv for full protocol decode
   3.
      listening on eth0, link-type EN10MB (Ethernet),
capture size 96 bytes
   4.
      13:56:53.621153 IP 203.212.228.2.47830 >
10.0.1.3.ssh: S 1286527220:1286527220(0
   5.
      ) win 5840 <mss 1380,sackOK,timestamp 7528651
0,nop,wscale 2>
   6.
      13:56:53.622702 IP 10.0.1.3.ssh >
203.212.228.2.47830: S 218882536:218882536(0)
   7.
      ack 1286527221 win 5792 <mss
1460,sackOK,timestamp 50762500 7528651,nop,wscale 2
   8.
      >
   9.
      13:56:53.632750 IP 203.212.228.2.47830 >
10.0.1.3.ssh: R 1:1(0) ack 1 win 5792 <
  10.
      mss 1460,sackOK,timestamp 50762500
7528651,nop,wscale 2>
  11.
      13:56:56.620293 IP 203.212.228.2.47830 >
10.0.1.3.ssh: S 1286527220:1286527220(0
  12.
      ) win 5840 <mss 1380,sackOK,timestamp 7531651
0,nop,wscale 2>
  13.
      13:56:56.620383 IP 10.0.1.3.ssh >
203.212.228.2.47830: S 221881892:221881892(0)
  14.
      ack 1286527221 win 5792 <mss
1460,sackOK,timestamp 50765500 7531651,nop,wscale 2
  15.
      >
  16.
      13:56:56.628686 IP 203.212.228.2.47830 >
10.0.1.3.ssh: R 1:1(0) ack 1 win 5792 <
  17.
      mss 1460,sackOK,timestamp 50765500
7531651,nop,wscale 2>
  18.
      13:57:02.620108 IP 203.212.228.2.47830 >
10.0.1.3.ssh: S 1286527220:1286527220(0
  19.
      ) win 5840 <mss 1380,sackOK,timestamp 7537651
0,nop,wscale 2>
  20.
      13:57:02.620209 IP 10.0.1.3.ssh >
203.212.228.2.47830: S 227881720:227881720(0)
  21.
      ack 1286527221 win 5792 <mss
1460,sackOK,timestamp 50771500 7537651,nop,wscale 2
  22.
      >
  23.
      13:57:02.633006 IP 203.212.228.2.47830 >
10.0.1.3.ssh: R 1:1(0) ack 1 win 5792 <
  24.
      mss 1460,sackOK,timestamp 50771500
7537651,nop,wscale 2>
  25.
      13:57:14.617988 IP 203.212.228.2.47830 >
10.0.1.3.ssh: S 1286527220:1286527220(0
  26.
      ) win 5840 <mss 1380,sackOK,timestamp 7549651
0,nop,wscale 2>
  27.
      13:57:14.618071 IP 10.0.1.3.ssh >
203.212.228.2.47830: S 239879584:239879584(0)
  28.
      ack 1286527221 win 5792 <mss
1460,sackOK,timestamp 50783500 7549651,nop,wscale 2
  29.
      >
  30.
      13:57:14.627490 IP 203.212.228.2.47830 >
10.0.1.3.ssh: R 1:1(0) ack 1 win 5792 <
  31.
      mss 1460,sackOK,timestamp 50783500
7549651,nop,wscale 2>
  32.
      13:57:23.841359 IP 203.212.228.2.47831 >
10.0.1.3.ssh: S 1316260936:1316260936(0
  33.
      ) win 5840 <mss 1380,sackOK,timestamp 7558875
0,nop,wscale 2>
  34.
      13:57:23.841465 IP 10.0.1.3.ssh >
203.212.228.2.47831: S 254860690:254860690(0)
  35.
      ack 1316260937 win 5792 <mss
1460,sackOK,timestamp 50792725 7558875,nop,wscale 2
  36.
      >
  37.
      13:57:23.850002 IP 203.212.228.2.47831 >
10.0.1.3.ssh: R 1:1(0) ack 1 win 5792 <
  38.
      mss 1460,sackOK,timestamp 50792725
7558875,nop,wscale 2>
  39.
      13:57:26.841055 IP 203.212.228.2.47831 >
10.0.1.3.ssh: S 1316260936:1316260936(0
  40.
      ) win 5840 <mss 1380,sackOK,timestamp 7561875
0,nop,wscale 2>
  41.
      13:57:26.841164 IP 10.0.1.3.ssh >
203.212.228.2.47831: S 257860388:257860388(0)
  42.
      ack 1316260937 win 5792 <mss
1460,sackOK,timestamp 50795725 7561875,nop,wscale 2
  43.
      >
  44.
      13:57:26.851353 IP 203.212.228.2.47831 >
10.0.1.3.ssh: R 1:1(0) ack 1 win 5792 <
  45.
      mss 1460,sackOK,timestamp 50795725
7561875,nop,wscale 2>
  46.
      13:57:32.840365 IP 203.212.228.2.47831 >
10.0.1.3.ssh: S 1316260936:1316260936(0
  47.
      ) win 5840 <mss 1380,sackOK,timestamp 7567875
0,nop,wscale 2>
  48.
      13:57:32.840477 IP 10.0.1.3.ssh >
203.212.228.2.47831: S 263859702:263859702(0)
  49.
      ack 1316260937 win 5792 <mss
1460,sackOK,timestamp 50801725 7567875,nop,wscale 2
  50.
      >
  51.
      13:57:32.847324 IP 203.212.228.2.47831 >
10.0.1.3.ssh: R 1:1(0) ack 1 win 5792 <
  52.
      mss 1460,sackOK,timestamp 50801725
7567875,nop,wscale 2>
  53.
      13:57:44.839402 IP 203.212.228.2.47831 >
10.0.1.3.ssh: S 1316260936:1316260936(0
  54.
      ) win 5840 <mss 1380,sackOK,timestamp 7579875
0,nop,wscale 2>
  55.
      13:57:44.839510 IP 10.0.1.3.ssh >
203.212.228.2.47831: S 275858733:275858733(0)
  56.
      ack 1316260937 win 5792 <mss
1460,sackOK,timestamp 50813726 7579875,nop,wscale 2
  57.
      >
  58.
      13:57:44.847581 IP 203.212.228.2.47831 >
10.0.1.3.ssh: R 1:1(0) ack 1 win 5792 <
  59.
      mss 1460,sackOK,timestamp 50813726
7579875,nop,wscale 2> 



Thank you

------------------------------------------------------------------
HAVE FUN, SOLVER SUDOKU, SHARPEN YOUR BRAIN.
Sudoku solver : http://users.kaski-net.net/~deepan/sudoku/sudoku.php
------------------------------------------------------------------
Deepan Chakravarthy N,
College student by day, Programmer by nite.
------------------------------------------------------------------
Home Page: http://users.kaski-net.net/~deepan/
Center for Biotechnology,
Anna University, Chennai,
Tamil Nadu, India.
Ph 91-44-55127050


		
__________________________________ 
Yahoo! Music Unlimited 
Access over 1 million songs. Try it free.
http://music.yahoo.com/unlimited/
